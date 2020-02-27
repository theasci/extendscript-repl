#!/usr/bin/env ruby

require 'open3'
require 'readline'
require_relative './lib/ask_act.rb'

def help
	puts <<HELP
USAGE: #{$0} <indesign|photoshop> (default is indesign)
Type ExtendScript and hit Enter to execute. For instance:
	app.name
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
	.act do |command|
		escaped = command.gsub(/['"]/,"\\\\'")
		jxa = %Q(osascript -l JavaScript -e "var app = new Application('com.adobe.#{APP}'); app.#{APPS[APP]}('#{escaped}', {language: 'javascript'});")
		Open3.popen3(jxa) do |stdin, stdout, stderr, thread|
			puts stdout.read.chomp.gsub("\r", "\r\n")
		end
	end
	.rescue(Interrupt) { |loop| puts; loop.next } # ^C
	.run
