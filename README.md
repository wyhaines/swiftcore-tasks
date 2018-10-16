# Swiftcore::Tasks

This little library encapsulates a very simple task queue implementation.
Tasks have a priority, and an object that responds to #call.

A TaskList is a set of Task objects that it orders according to priority.

The Tasklist allows running the whole queue of tasks, or running just a single
task at a time.

If any Task returns a TaskList, that TaskList gets merged into the parent's
list of tasks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'swiftcore-tasks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install swiftcore-tasks

## Usage

```ruby
result_list = []
list = Swiftcore::Tasks::TaskList.new
list << Swiftcore::Tasks::Task.new(4) { result_list << 3 }
list << Swiftcore::Tasks::Task.new(2) do
  sublist = Swiftcore::Tasks::TaskList.new
  sublist << Swiftcore::Tasks::Task.new(3) { result_list << 2 }
  sublist << Swiftcore::Tasks::Task.new(5) { result_list << 5 }
  sublist
end
list << Swiftcore::Tasks::Task.new(1) { result_list << 1 }

list.run
result_list == [1,2,3,5]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/swiftcore-tasks.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
