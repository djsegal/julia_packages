module Countable
  extend ActiveSupport::Concern

  included do
    columns = self.get_count_types

    columns.each do |column|
      define_method "#{column.pluralize}_count" do
        self.counter[column]
      end
    end
  end

  class_methods do
    def get_count_types
      clean_field_list Counter.column_names
    end
  end
end
