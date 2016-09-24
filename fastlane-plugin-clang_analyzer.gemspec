# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/clang_analyzer/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-clang_analyzer'
  spec.version       = Fastlane::ClangAnalyzer::VERSION
  spec.author        = %q{Siarhei Fiedartsou}
  spec.email         = %q{Sergei_Fedortsov@cedoni.com}

  spec.summary       = %q{Runs Clang Static Analyzer(http://clang-analyzer.llvm.org/) and generates report}
 spec.homepage      = "https://github.com/SiarheiFedartsou/fastlane-plugin-clang_analyzer"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.104.0'
end
