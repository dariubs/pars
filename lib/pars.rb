# -*- coding: UTF-8 -*-

require 'yaml'
require "haml"
require "fileutils"
require "kramdown"
require "tilt"


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

	def self.dir?(path)
		true
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
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
									autolink: true, tables: true,
									prettify: true,
									fenced_code_blocks: true)

		template = Tilt.new("view/theme.haml")

		Dir.glob("posts/**/" + "*.md") do |post|

			md_content = File.open(post,"r:UTF-8")

			html_content = markdown.render(md_content.read)
			html_file = post.sub("posts/","")
			html_dir = post.sub(/[\d]*\.?[\w]+.md$/,"").sub("posts/","")

			puts "for :" + post

			if html_dir != "" then
				FileUtils.mkdir_p(html_dir)
				puts(html_dir + "generated")
			end

			File.open(html_file.sub(".md",".html"), "w:UTF-8") { |io|
				io.write(template.render(self,:title => "title", :content => html_content))
				puts html_file + " created"
			}

			md_content.close
			
		end		
	end

end
