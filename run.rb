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

APP = (ARGV[0] || 'indesign').strip.downcase

# Contains the javascript method to execute extendscript
APPS = {
	'indesign' => 'doScript',
	'photoshop' => 'doJavascript',
}

puts <<PREFACE
ExtendScript REPL - #{APP}
Type 'help' to get started.
PREFACE

repl = AskAct.new
	.ask { Readline.readline("jsx> ", true) }
	.on('help', 'Show useful help text') { |loop| help }
	repl.act do |command|
		system "osascript -l 'JavaScript' -e \"var app = new Application('com.adobe.#{APP}'); app.#{APPS[APP]}('#{command}', {language: 'javascript'});\""
	end
	.rescue(Interrupt) { |loop| puts; loop.next } # ^C
	.run
