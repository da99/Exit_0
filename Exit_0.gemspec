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
  s.executables   = []
  s.require_paths = ["lib"]

  s.add_development_dependency 'bacon'         , '>= 1.2.0'
  s.add_development_dependency 'Bacon_Colored' , '> 0.1.2'
  s.add_development_dependency 'pry'           , '> 0.10.0'

  # Specify any dependencies here; for example:
  s.add_runtime_dependency 'posix-spawn', '> 0.3.8'
  s.add_runtime_dependency 'Split_Lines', '> 0.9.9'
  s.add_runtime_dependency 'open4',       '> 1.3.0'
end
