# frozen_string_literal: true

require 'test_helper'

module Swiftcore
  # Suite of tests fot the TaskList.
  class TasksTests < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Swiftcore::Tasks::VERSION
    end

    def test_make_a_tasklist
      list = Swiftcore::Tasks::TaskList.new
      assert list.is_a?(Swiftcore::Tasks::TaskList)
    end

    def test_make_a_task
      task = Swiftcore::Tasks::Task.new
      assert task.is_a?(Swiftcore::Tasks::Task)
    end

    def test_task_defaults_work
      task = Swiftcore::Tasks::Task.new
      assert task.order.zero?
      assert task.call.nil?
    end

    def test_task_records_order
      order = 9999
      task = Swiftcore::Tasks::Task.new(order) { 7 }
      assert task.order == order
    end

    def test_task_saves_callable_block
      task = Swiftcore::Tasks::Task.new(9999) { 7 }
      assert task.call == 7
    end

    def build_basic_tasklist
      list = Swiftcore::Tasks::TaskList.new
      list << Swiftcore::Tasks::Task.new(3) { 3 }
      list << Swiftcore::Tasks::Task.new(2) { 2 }
      list << Swiftcore::Tasks::Task.new(1) { 1 }
      list
    end

    def test_tasks_can_be_added_to_tasklist
      assert build_basic_tasklist.count == 3
    end

    def test_tasks_can_ticked_through_one_at_a_time
      list = build_basic_tasklist
      assert list.tick == 1
      assert list.tick == 2
      assert list.tick == 3
      assert list.empty?
    end

    def build_closure_tasklist(result_list = [])
      list = Swiftcore::Tasks::TaskList.new
      list << Swiftcore::Tasks::Task.new(3) { result_list << 3 }
      list << Swiftcore::Tasks::Task.new(2) { result_list << 2 }
      list << Swiftcore::Tasks::Task.new(1) { result_list << 1 }
      list
    end

    def test_tasks_can_ran_collectively
      result_list = []
      list = build_closure_tasklist(result_list)
      list.run
      assert result_list == [1, 2, 3]
      assert list.empty?
    end

    # rubocop:disable Metrics/AbcSize
    def build_nested_closure_tasklist(result_list = [])
      list = Swiftcore::Tasks::TaskList.new
      list << Swiftcore::Tasks::Task.new(4) { result_list << 3 }
      list << Swiftcore::Tasks::Task.new(2) do
        sublist = Swiftcore::Tasks::TaskList.new
        sublist << Swiftcore::Tasks::Task.new(3) { result_list << 2 }
        sublist << Swiftcore::Tasks::Task.new(5) { result_list << 5 }
        sublist
      end
      list << Swiftcore::Tasks::Task.new(1) { result_list << 1 }
      list
    end
    # rubocop:enable Metrics/AbcSize

    def test_tasks_can_add_additional_tasks
      result_list = []
      list = build_nested_closure_tasklist(result_list)
      list.run
      assert result_list == [1, 2, 3, 5]
      assert list.empty?
    end

    def build_tasklist_to_take_args(result_list)
      list = Swiftcore::Tasks::TaskList.new
      block = proc { |x| result_list << (result_list.last || 1) * x }
      list << Swiftcore::Tasks::Task.new(0, &block)
      list << Swiftcore::Tasks::Task.new(0, &block)
      list << Swiftcore::Tasks::Task.new(0, &block)
      list << Swiftcore::Tasks::Task.new(0, &block)
    end

    def test_tasks_with_args_work
      result_list = []
      list = build_tasklist_to_take_args(result_list)
      list.run(2)
      assert result_list == [2, 4, 8, 16]
      assert list.empty?
    end
  end
end
