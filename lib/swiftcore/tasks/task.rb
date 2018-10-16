# frozen_string_literal: true

module Swiftcore
  module Tasks
    # This is a sortable, orderable container for a #call()able object.
    class Task
      include Comparable

      attr_accessor :order, :status, :result
      attr_reader :task, :taskord

      def initialize(order = 0, &task)
        @order = order
        self.task = task
        @status = :pending
        @result = nil
      end

      def task=(val)
        @taskord = val.to_s
        @task = val
      end

      def less_than(other)
        (@order < other.order) ||
          (@order == other.order && @taskord < other.taskord)
      end

      def greater_than(other)
        (@order > other.order) ||
          (@order == other.order && @taskord > other.taskord)
      end

      def <=>(other)
        if less_than(other)
          -1
        elsif greater_than(other)
          1
        else
          0
        end
      end

      def call(*args)
        @status = :running
        @result = @task&.call(*args)
        @status = :finished
        @result
      rescue StandardError => e
        @status = e
      end
    end
  end
end
