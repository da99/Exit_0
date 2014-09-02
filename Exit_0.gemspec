# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = "Exit_0"
  s.version     = `cat VERSION`
  s.authors     = ["da99"]
  s.email         = ["i-hate-spam-1234567@mailinator.com"]
  s.homepage    = "https://github.com/da99/Exit_0"
  s.summary     = %q{Make sure your last child process exited with 0.}
  s.description = %q{
    A simple method that runs a child process and raises
    Exit_0::Non_0 if $?.exitstatus is not zero.
  }

  s.license       = "MIT"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'bacon'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'Bacon_Colored'
  s.add_development_dependency 'pry'
  
  # Specify any dependencies here; for example:
  s.add_runtime_dependency 'posix-spawn'
  s.add_runtime_dependency 'Split_Lines'
  s.add_runtime_dependency 'open4'
end
