# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'excon_honeypot'
  spec.version       = '0.1.13'
  spec.authors       = ['Andrzej Trzaska']
  spec.email         = ['atrzaska2@gmail.com']

  spec.summary       = 'Honeypot defaults for excon gem'
  spec.description   = 'Honeypot defaults for excon gem.'
  spec.homepage      = 'https://github.com/honeypotio/excon_honeypot'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/honeypotio/excon_honeypot'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
  spec.add_dependency 'excon', '< 1'
end
