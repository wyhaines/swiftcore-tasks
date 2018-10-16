# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swiftcore/tasks/version'

Gem::Specification.new do |spec|
  spec.name = 'swiftcore-tasks'
  spec.version = Swiftcore::Tasks::VERSION
  spec.authors = ['Kirk Haines']
  spec.email = ['kirk-haines@cookpad.com']

  spec.summary = <<~ESUMMARY
    Simple task list library.
  ESUMMARY
  spec.description = <<~EDESCRIPTION
    This is a very simple task list library that I use in a bunch of other places.
  EDESCRIPTION
  spec.homepage = 'https://github.com/wyhaines/swiftcore-tasks'
  spec.license = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
