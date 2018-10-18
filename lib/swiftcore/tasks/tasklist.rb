# frozen_string_literal: true

require 'set'
require 'swiftcore/tasks/task'

module Swiftcore
  module Tasks
    # Just a SortedSet with a few special powers.
    class TaskList < SortedSet
      attr_accessor :status

      def initialize(*args)
        @status = :pending
        super(*args)
      end

      def run(*args)
        @status = :running
        tick(*args) while any?
        @status = :finished
      end

      def finished?
        @status = :finished if empty?
        @status == :finished
      end

      # Run a single task in the queue.
      def tick(*args)
        prior_status = @status
        @status = :tick
        task = first
        result = task.call(*args)
        delete task
        merge(result) if result.is_a?(TaskList)
        @status = prior_status
        finished?
        result
      end
    end
  end
end
