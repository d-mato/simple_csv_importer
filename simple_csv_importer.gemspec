lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_csv_importer/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_csv_importer'
  spec.version       = SimpleCsvImporter::VERSION
  spec.authors       = ['Daiki Matoba']
  spec.email         = ['telnetstat@gmail.com']

  spec.summary       = %q{Convert CSV data to instances of model and import to database easily.}
  spec.description   = %q{Convert CSV data to instances of model and import to database easily.}
  spec.homepage      = 'https://github.com/d-mato/simple_csv_importer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
