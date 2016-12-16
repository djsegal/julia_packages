module Countable
  extend ActiveSupport::Concern

  included do
    columns = clean_field_list Counter.column_names

    columns.each do |column|
      define_method "#{column.pluralize}_count" do
        self.counter[column]
      end
    end
  end
end
