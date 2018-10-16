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


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/swiftcore-tasks.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
