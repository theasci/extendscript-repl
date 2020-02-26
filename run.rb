#!/usr/bin/env ruby

require 'readline'
require_relative './lib/ask_act.rb'

def help
	puts <<HELP
USAGE: #{$0} <indesign|photoshop> (default is indesign)
Type ExtendScript and hit Enter to execute. For instance:
	app.properties.name
Type 'list' to see available commands
To quit, type 'quit' or 'exit' or 'stop'.
HELP
end

APP = ($1 || 'indesign').strip.downcase

puts <<PREFACE
ExtendScript REPL - #{APP}
Type 'help' to get started.

PREFACE
AskAct.new
	.ask { Readline.readline("jsx> ", true) }
	.act do |command|
		system "osascript -l 'JavaScript' -e \"var app = new Application('com.adobe.#{APP}'); app.doScript('#{command}', {language: 'javascript'});\""
	end
	.on('help', 'Show useful help text') { |loop| help }
	.on('app', 'Display the application we are executing extendscript in') { |loop| puts APP }
	.rescue(Interrupt) { |loop| puts; loop.next } # ^C
	.run
