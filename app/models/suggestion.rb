# == Schema Information
#
# Table name: suggestions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :bigint           not null
#  package_id      :bigint           not null
#  sub_category_id :bigint
#
# Indexes
#
#  index_suggestions_on_category_id      (category_id)
#  index_suggestions_on_package_id       (package_id)
#  index_suggestions_on_sub_category_id  (sub_category_id)
#  unique_combination_index              (package_id,category_id,sub_category_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (package_id => packages.id)
#  fk_rails_...  (sub_category_id => categories.id)
#
class Suggestion < ApplicationRecord

  belongs_to :category
  belongs_to :package

  belongs_to :sub_category, required: false, class_name: "Category", foreign_key: "sub_category_id"

  validates_uniqueness_of :package_id, scope: [:category_id, :sub_category_id]

  def self.to_csv
    attributes = %w[ package category sub_category ]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.find_each do |suggestion|
        csv << attributes.map{ |attr| suggestion.send(attr).try(:name) || "" }
      end
    end
  end

end
