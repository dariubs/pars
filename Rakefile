
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pars/version'


task :buildgem do 
	sh("gem build pars.gemspec")
end

task :installgem do 
	sh("gem install pars-" + Pars::VERSION + ".gem")
end

task :default =>[:buildgem, :installgem] do 

end