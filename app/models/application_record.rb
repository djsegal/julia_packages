class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.custom_find *args
    self.friendly.find *args
  end

  def self.custom_exists? *args
    self.friendly.exists? *args
  end
end
