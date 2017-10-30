lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mini_stitch/version"

Gem::Specification.new do |spec|
  spec.name          = "mini_stitch"
  spec.version       = MiniStitch::VERSION
  spec.authors       = ["theminijohn"]
  spec.email         = ["its@minijohn.me"]

  spec.summary       = %q{Ruby Wrapper for the Sitch Data Import Api}
  spec.description   = %q{Ruby Wrapper for the Upsert & Validate method used by the Stitch Data Import API}
  spec.homepage      = "https://www.github.com/theminijohn/mini_stitch"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'pry', '~> 0.10.4'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 12.2.1'
  spec.add_development_dependency 'rspec', '~> 3.7.0'

  spec.add_dependency 'json', '~> 2.1'
  spec.add_dependency 'oj', '~> 3.3', '>= 3.3.9'
  spec.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
end
