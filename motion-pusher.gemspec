# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'motion-pusher/version'

Gem::Specification.new do |spec|
  spec.name          = "motion-pusher"
  spec.version       = MotionPusher::VERSION
  spec.authors       = ["David Larrabee"]
  spec.email         = ["david.larrabee@meyouhealth.com"]
  spec.description   = %q{RubyMotion interface to the Pusher}
  spec.summary       = %q{RubyMotion interface to the Pusher}
  spec.homepage      = "https://github.com/squidpunch/motion-pusher"
  spec.license       = 'MIT'

  files = []
  files << 'README.md'
  files << 'LICENSE'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "motion-cocoapods", "~> 1.8"

  spec.add_development_dependency 'bacon'
  spec.add_development_dependency 'rake'
end
