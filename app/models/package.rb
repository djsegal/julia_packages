# == Schema Information
#
# Table name: packages
#
#  id          :bigint           not null, primary key
#  created     :datetime
#  description :string
#  github_url  :string
#  name        :string
#  owner       :string
#  search      :text
#  stars       :integer
#  updated     :datetime
#  website     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Package < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search, against: :search, order_within_rank: "packages.updated DESC"

  has_one :readme, dependent: :destroy

end
