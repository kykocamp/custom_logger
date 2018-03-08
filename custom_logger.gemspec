# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'custom_logger/version'

Gem::Specification.new do |gem|
  gem.name          = "custom_logger"
  gem.version       = CustomLogger::VERSION
  gem.authors       = ["Rodrigo P Campos"]
  gem.email         = ["rodrigo@rodrigopcampos.com.br"]
  gem.description   = %q{Create custom loggers fully configurable in Rails.}
  gem.summary       = %q{Provide helper to define loggers and access them. Each logger will log into a different file under the log folder, or the folder you set in configuration file.}

  gem.homepage      = "https://github.com/kykocamp/custom_logger"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'railties'
  gem.add_development_dependency "activesupport"
  gem.add_development_dependency "mocha"
end
