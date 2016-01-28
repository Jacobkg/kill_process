# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kill_process/version'

Gem::Specification.new do |spec|
  spec.name          = "kill_process"
  spec.version       = KillProcess::VERSION
  spec.authors       = ["Jacob Green"]
  spec.email         = ["jacob@nationbuilder.com"]

  spec.summary       = 'Use UNIX posix timers to guarantee a process dies after N seconds'
  spec.description   = 'Use UNIX posix timers to guarantee a process dies after N seconds'
  spec.homepage      = "https://github.com/Jacobkg/kill_process"
  spec.license       = "MIT"

  spec.extensions       = 'ext/extconf.rb'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rake-compiler'
end
