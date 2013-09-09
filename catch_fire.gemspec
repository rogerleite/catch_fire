# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'catch_fire/version'

Gem::Specification.new do |spec|
  spec.name          = "catch_fire"
  spec.version       = CatchFire::VERSION
  spec.authors       = ["Roger Leite"]
  spec.email         = ["roger.barreto@gmail.com"]
  spec.description   = %q{Catch exceptions using an awesome DSL}
  spec.summary       = %q{Catch exceptions using an awesome DSL}
  spec.homepage      = "https://github.com/rogerleite/catch_fire"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 3"
end
