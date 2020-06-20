# == Schema Information
#
# Table name: suggestions
#
#  id                :bigint           not null, primary key
#  category_slug     :string
#  package_slug      :string
#  sub_category_slug :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Suggestion < ApplicationRecord

  validates :package_slug, presence: true
  validates :category_slug, presence: true

  validates_uniqueness_of :package_slug, scope: [:category_slug, :sub_category_slug]

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << %w[ package category sub_category ]

      all.find_each do |suggestion|
        csv_row = []

        csv_row << Package.friendly.find(suggestion.package_slug).name
        csv_row << Category.friendly.find(suggestion.category_slug).name

        if suggestion.sub_category_slug.blank?
          csv_row << ""
        else
          csv_row << Category.friendly.find(suggestion.sub_category_slug).name
        end

        csv << csv_row
      end
    end
  end

end
