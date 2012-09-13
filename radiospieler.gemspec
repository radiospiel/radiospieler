class Gem::Specification
  class GemfileEvaluator
    def initialize(scope)
      @scope = scope
    end
    
    def load_dependencies(path)
      instance_eval File.read(path) 
    end
    
    def source(*args); end
    def group(*args); end

    def gem(name, options = {})
      @scope.add_dependency(name)
    end
  end
  
  def load_dependencies(file)
    GemfileEvaluator.new(self).load_dependencies(file)
  end
end

Gem::Specification.new do |gem|
  gem.name          = "radiospieler"
  gem.authors       = ["radiospiel"]
  gem.email         = ["eno@open-lab.org"]
  gem.description   = %q{Some basics that your application could benefit from.}
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/radiospiel/radiospieler"
  gem.licenses      = ["MIT"]

  gem.load_dependencies "Gemfile"
  
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.version       = Time.now.strftime "%Y\.%m\.%d" 
  gem.date          = Time.now.strftime "%Y-%m-%d" 

  gem.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
end
