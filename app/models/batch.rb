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

end
