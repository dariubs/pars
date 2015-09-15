# -*- coding: UTF-8 -*-

require 'yaml'
require "haml"
require "fileutils"
require "kramdown"
require "tilt"
require "pars/generate"

module Pars

	def isParsDir?
		if File.exist?(".pars.yml") then
			true
		else
			false
		end
	end

	def anyPost?
		if File.exist?(Dir.pwd + "/posts") then
			true
		else
			false
		end
	end

	def dir?(path)
		true
	end

	def generate
		gen = Pars::Generate.new
		gen.generate!
	end

end
