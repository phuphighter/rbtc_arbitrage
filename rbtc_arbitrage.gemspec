# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbtc_arbitrage/version'

Gem::Specification.new do |spec|
  spec.name          = "rbtc_arbitrage"
  spec.version       = RbtcArbitrage::VERSION
  spec.authors       = ["Hank Stoever"]
  spec.email         = ["hstove@gmail.com"]
  spec.description   = %q{A gem for conducting arbitrage with Bitcoin.}
  spec.summary       = %q{A gem for conducting arbitrage with Bitcoin.}
  spec.homepage      = "https://github.com/hstove/rbtc_arbitrage"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "rake", "10.1.1"

  spec.add_dependency "faraday", "0.8.8"
  spec.add_dependency "activemodel", "~> 4.0"
  spec.add_dependency "activesupport", "~> 4.0"
  spec.add_dependency "thor", '0.18.1'
  spec.add_dependency "btce", '0.2.4'
  spec.add_dependency "stathat", '0.1.7'
  spec.add_dependency "coinbase", '2.1.0'
  spec.add_dependency "pony", '1.10'
  spec.add_dependency "tco", "0.1.0"
  spec.add_dependency "bitstamp-rbtc-arbitrage", "0.4.0"
  spec.add_dependency "tzinfo", '~> 1.1'
  spec.add_dependency "mail", "2.5.4"
end
