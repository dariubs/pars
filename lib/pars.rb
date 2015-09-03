require 'yaml'
require "fileutils"
require "kramdown"

class Pars

	def self.isParsDir?
		if File.exist?(".pars.yml") then
			true
		else
			false
		end
	end

	def self.anyPost?
		if File.exist?(Dir.pwd + "/posts") then
			true
		else
			false
		end
	end

	def self.directory_hash(path, name=nil)

	  data = {:data => (name || path)}
	  data[:children] = children = []

	  Dir.foreach(path) do |entry|

	    next if (entry == '..' || entry == '.')

	    full_path = File.join(path, entry)

	    if File.directory?(full_path)
	      children << directory_hash(full_path, entry)
	    else
	      children << entry
	    end
	  end

	  return data
	end

	def self.generate
		Dir.glob(Dir.pwd + "/posts/" + "*.md") do |doc|
			puts doc
		end
		
	end

end
