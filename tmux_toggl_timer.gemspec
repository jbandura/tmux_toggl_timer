# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tmux_toggl_timer/version'

Gem::Specification.new do |spec|
  spec.name          = "tmux_toggl_timer"
  spec.version       = TmuxTogglTimer::VERSION
  spec.authors       = ["jbandura"]
  spec.email         = ["jacek.bandura@netguru.pl"]

  spec.summary       = %q{Display toggl data in your tmux status line}
  spec.description   = %q{Display toggl data in your tmux status line}
  spec.homepage      = "https://github.com/jbandura/tmux_toggl_timer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = ['lib/tmux_toggl_timer/timer.rb', 'lib/tmux_toggl_timer/toggl_fetcher.rb']
  spec.bindir        = "bin"
  spec.executables   = ['tmux_toggl_timer']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'faraday', "~> 0.9.2"
  spec.add_development_dependency "rspec", "~> 3.5.0"
  spec.add_development_dependency "rspec-mocks", "~> 3.5.0"
end
