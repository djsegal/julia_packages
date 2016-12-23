module Ownable
  extend ActiveSupport::Concern

  included do

    extend FriendlyId
    friendly_id :name

    has_many :owned_packages, as: :owner, class_name: "Package"

    has_one :profile, as: :owner
    has_one :info, as: :owner

    def url
      "https://github.com/#{name}"
    end

  end

  class_methods do
    def get_count_types
      clean_field_list Info.column_names
    end
  end

end
