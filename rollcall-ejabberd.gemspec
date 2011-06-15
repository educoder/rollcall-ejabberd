Gem::Specification.new do |s|
  s.name = %q{ejabberd-rollcall}
  s.version = "0.0.1"
  s.authors = ["Matt Zukowski"]
  s.date = %q{2011-06-15}
  s.summary = %q{Rollcall plugin for Ejabberd management}
  s.email = %q{matt dot zukowski at utoronto dot ca}
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{http://github.com/educoder/rollcall-ejabberd}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rollcall-ejabberd}
end
