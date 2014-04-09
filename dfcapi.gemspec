Gem::Specification.new do |s|
  s.name        = 'dfcapi'
  s.version     = '1.0.0'
  s.summary     = "DFCAPI-Ruby"
  s.description = "DFC API - PHP Client Library"
  s.authors     = ["Debit Finance Collections Plc"]
  s.email       = 'development@debitfinance.co.uk'
  s.homepage    = 'https://github.com/dfcplc/dfcapi-ruby'
  s.license     = 'MIT'

	s.add_dependency('rest-client', '~> 1.6.7')
	s.add_dependency('json', '~> 1.8.1')
	s.add_dependency('addressable', '~> 2.3.5')
    s.add_dependency('unirest', '~> 1.1.2')

	s.add_development_dependency('shoulda', '~> 3.5.0')
	s.add_development_dependency('test-unit')
	s.add_development_dependency('rake')

	s.required_ruby_version = '~> 2.0'

  s.files       = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ['lib']

end
