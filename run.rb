#!/usr/bin/env ruby

require 'optparse'
require 'open3'
require 'readline'
require_relative './lib/ask_act.rb'

# Contains the javascript method to execute extendscript
APPS = {
	'indesign' => 'doScript',
	'photoshop' => 'doJavascript',
}
appName = 'indesign'
doMethod = APPS[appName]
bootstrapFile = nil

OptionParser.new do |parser|
	parser.on('-h','--help', 'Prints this help') do |help|
		puts parser
		exit 0
	end
	parser.on('-aAPP','--app=APP', 'Application name, e.g. indesign or photoshop. The defaults is indesign.') do |app|
		appName = app.strip.downcase
	end
	parser.on('-bFILE','--bootstrap=FILE', 'ExtendScript JSX file to load.') do |bootstrap|
		bootstrapFile = File.expand_path(bootstrap.strip)
	end
end.parse!

puts <<PREFACE
ExtendScript REPL - #{appName}
Type 'help' to get started.
PREFACE

AskAct.new
	.ask { Readline.readline("jsx> ", true) }
	.on('help', 'Show useful help text') do |loop|
		puts <<HELP
Type ExtendScript and hit Enter to execute. For instance:
	app.name
Type 'list' to see available commands
To quit, type 'quit' or 'exit' or 'stop'.
HELP
	end
	.act do |command|
		escaped = command.gsub(/(['"\\])/,'\\\\\1')
		
		# build ExtendScript to send to application
		jsx = "var app = new Application('com.adobe.#{appName}'); app.#{doMethod}('"
		if bootstrapFile
			jsx += "$.evalFile(\\'#{bootstrapFile}\\');"
		end
		jsx += "#{escaped};', {language: 'javascript'});"
		
		jxa = %Q(osascript -l JavaScript -e "#{jsx}")
		Open3.popen3(jxa) do |stdin, stdout, stderr, thread|
			out = stdout.read.chomp
			puts out.gsub("\r", "\r\n") unless out.empty?
			err = stderr.read.chomp
			puts err.chomp.gsub("\r", "\r\n") unless err.empty?
		end
	end
	.rescue(Interrupt) do |loop| # ^C
		puts "\nTo quit, type 'quit' or 'exit' or 'stop'."
		loop.next
	end
	.run
