# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'umarell/version'

Gem::Specification.new do |s|
  s.name = 'umarell'
  s.version = Umarell::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.0'
  s.authors = ['Filippo Liverani']
  s.description = 'All in one Ruby static code analyzer'

  s.email = 'hello@nebulab.it'
  s.files = `git ls-files assets exe lib LICENSE.txt README.md`.split($RS)
  s.bindir = 'exe'
  s.executables = ['umarell']
  s.require_path = 'lib'
  s.extra_rdoc_files = ['LICENSE.txt', 'README.md']
  s.homepage = 'https://github.com/nebulab/umarell'
  s.licenses = ['MIT']
  s.summary = 'All in one Ruby static code analyzer'

  s.add_runtime_dependency('brakeman', '~> 4.7')
  s.add_runtime_dependency('bundler-audit', '< 1')
  s.add_runtime_dependency('erb_lint', '< 1')
  s.add_runtime_dependency('fasterer', '< 1')
  s.add_runtime_dependency('rails_best_practices', '~> 1.19')
  s.add_runtime_dependency('reek', '~> 5.5')
  s.add_runtime_dependency('rubocop', '< 1')
  s.add_runtime_dependency('rubocop-performance', '~> 1.5')
  s.add_runtime_dependency('rubocop-rails', '~> 2.4')
  s.add_runtime_dependency('rubocop-rake', '< 1')
  s.add_runtime_dependency('rubocop-rspec', '~> 1.37')

  s.add_development_dependency('bundler', '~> 2.0')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('rspec', '~> 3.9')
end
