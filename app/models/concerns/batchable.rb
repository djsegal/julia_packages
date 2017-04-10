module Batchable
  extend ActiveSupport::Concern

  included do

    has_one :batch, as: :item

    delegate :marker, to: :batch, prefix: true

    after_create :add_batch_marker

    private

      def add_batch_marker
        self.create_batch
      end

  end

  class_methods do
    def active_batch_scope
      joins(:batch)
        .where(batches: { marker: Batch.active_marker })
    end

    def current_batch_scope
      joins(:batch)
        .where(batches: { marker: Batch.current_marker })
    end

    def custom_find *args
      begin
        found_item = self.active_batch_scope.friendly.find *args
      rescue ActiveRecord::RecordNotFound
        found_item = backup_find(*args)
      end
      found_item
    end

    def custom_exists? *args
      does_exist = self.active_batch_scope.friendly.exists? *args
      does_exist ||= backup_find(*args).present?
      does_exist
    end

    def backup_find *args
      matched_name = args.first

      possible_items = self.active_batch_scope.where \
        "name ILIKE ?", "%#{args.first}%"

      matched_name.downcase!

      possible_items.each do |possible_item|
        cur_name = possible_item.name.downcase
        is_item = ( cur_name == matched_name )
        return possible_item if is_item
      end

      matched_name.gsub! /[-_]/, ''

      possible_items.each do |possible_item|
        cur_name = possible_item.name.downcase
        cur_name = cur_name.gsub /[-_]/, ''

        is_item = ( cur_name == matched_name )
        return possible_item if is_item
      end

      nil
    end
  end

end
