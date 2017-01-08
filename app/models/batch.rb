# == Schema Information
#
# Table name: batches
#
#  id         :integer          not null, primary key
#  marker     :integer
#  item_type  :string
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_batches_on_item_type_and_item_id  (item_type,item_id)
#  index_batches_on_marker                 (marker)
#

class Batch < ApplicationRecord

  @@current_marker = get_initial_batch_marker :current, 1
  @@active_marker = get_initial_batch_marker :active, nil

  cattr_accessor :current_marker
  cattr_accessor :active_marker

  belongs_to :item, polymorphic: true, dependent: :destroy
  before_create :set_current_marker

  private

    def set_current_marker
      self.marker = @@current_marker
    end

    def self.reload_batch_markers
      batch_directory = 'tmp/batch'
      marker_types = %w[ current active ]

      marker_types.each do |marker_type|
        file_name = "#{marker_type}.yml"
        file_path = "#{batch_directory}/#{file_name}"

        new_value = YAML.load_file(file_path)
        class_var = "@@#{marker_type}_marker"
        self.class_variable_set class_var, new_value
      end
    end

end
