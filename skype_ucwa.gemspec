Gem::Specification.new do |s|
  s.name        = 'skype_ucwa'
  s.version     = '0.0.1'
  s.date        = '2016-04-26'
  s.summary     = "Skype UCWA API Client"
  s.description = "Skype UCWA API Client"
  s.authors     = ["Saul Moncada"]
  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency "httplog"
  s.add_dependency "rest-client", "2.0.0.rc2"
end
