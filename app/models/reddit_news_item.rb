# == Schema Information
#
# Table name: news_items
#
#  id          :integer          not null, primary key
#  name        :string
#  target_type :string
#  target_id   :integer
#  link        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type        :string
#  position    :integer
#
# Indexes
#
#  index_news_items_on_position                   (position)
#  index_news_items_on_target_type_and_target_id  (target_type,target_id)
#

class RedditNewsItem < NewsItem
end
