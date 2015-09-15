# external dependencies
require 'haml'
require 'tilt'


# stdlib dependencies
require 'fileutils'
require 'yaml'

# internal files


module Pars
	class Generate
		
		def initialize
			@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
							autolink: true, tables: true,
							prettify: true,
							fenced_code_blocks: true)

			@settings = getSetting
		end

		def generate!
			removeFiles
			createFiles
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

		def getTheme(item=nil)


		end

		def getSetting(item=nil)
			
			default_settings = {
				"title" => "Title of site",
				"description" => "Yet another static website"
				}

			user_settings = File.open(".pars.yml") { |file| YAML.load(file) } 

			settings = {
				"title" => if $user_settings then if $user_settings["title"] != nil then $user_settings["title"] else $default_settings["title"] end else $default_settings["title"] end,
				"description" => if $user_settings then if $user_settings["description"] != nil then $user_settings["description"] else $default_settings["description"] end else $default_settings["description"] end
				} 			


			if item == nil then
				return settings
			else
				return settings[item]
			end

		end

		# Combine HTML Content with theme files
		def generatePage
			
		end

		# Create file from generated page
		def createFiles
			template = Tilt.new("view/theme.haml")

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

		# Get Important File from config file
		# Don't remove this files and dirs in regenerate website
		def getImportantFilesList
			userfiles = getSetting("important")
			systemfiles = ["posts","view",".git",".pars.yml"]

			if userfiles != nil || userfiles.kind_of?(Array) then
				files = (userfiles + systemfiles).uniq

			elsif userfiles != nil || userfiles.kind_of?(String)
				files = systemfiles.push(userfiles).uniq
			else
				files = systemfiles
			end

			return files
		end

		# Remove files related to last site generate
		def removeFiles
			filetant = getImportantFilesList

			Dir.foreach(Dir.pwd) do |item|
				next if item == '.' or item == '..'
				if !filetant.include? item then
					FileUtils.rm_rf item 
					puts "remove :" + item
				end
			end
		end
	end
end