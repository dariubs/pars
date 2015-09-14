# external dependencies
require 'yaml'
require "haml"
require "fileutils"
require "kramdown"
require "tilt"


# stdlib dependencies

# internal files


module Pars
	class Generate
		
		def initialize
			@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
							autolink: true, tables: true,
							prettify: true,
							fenced_code_blocks: true)


		end

		# generate index file for specific paths
		def generateIndex

		end

		# Generate HTML content from Markdown
		def generateHTMLContent

		end

		# Create Directory Structure from Contents Directory Structure
		def createDirStructure

		end

		# Get Content of a file
		def getFileContent

		end

		# Combine HTML Content with theme files
		def generatePage
			
			template = Tilt.new("view/theme.haml")

			filetant = ["posts","view",".pars.yml"]

			Dir.foreach(Dir.pwd) do |item|
				next if item == '.' or item == '..'
				if !filetant.include? item then
					FileUtils.rm_rf item 
					puts "remove :" + item
				end
			end

			Dir.glob("posts/**/" + "*.md") do |post|

				md_content = File.open(post,"r:UTF-8")

				html_content = @markdown.render(md_content.read)
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

		# Create file from generated page
		def createFile

		end

		# Get Important File from config file
		# Don't remove this files and dirs in regenerate website
		def getImportantFiles

		end
	end
end