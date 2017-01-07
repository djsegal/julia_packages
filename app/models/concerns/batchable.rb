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
      self.active_batch_scope.friendly.find *args
    end

    def custom_exists? *args
      self.active_batch_scope.friendly.exists? *args
    end
  end

end
