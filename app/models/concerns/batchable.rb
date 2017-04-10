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

    def custom_find *args, batch_scope: "active_batch_scope"
      begin
        found_item = self.public_send(batch_scope).friendly.find *args
      rescue ActiveRecord::RecordNotFound
        found_item = backup_find(*args, batch_scope: batch_scope)
      end
      found_item
    end

    def custom_exists? *args, batch_scope: "active_batch_scope"
      does_exist = self.public_send(batch_scope).friendly.exists? *args
      does_exist ||= backup_find(*args, batch_scope: batch_scope).present?
      does_exist
    end

    def backup_find *args, batch_scope: "active_batch_scope"
      matched_name = args.first.clone

      possible_items = self.public_send(batch_scope).where \
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
