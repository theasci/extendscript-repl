# Borrowed from https://github.com/jocap/ask-act

class NextIteration < StandardError
end

class LoopControl
	def break
		raise StopIteration
	end
	def next
		raise NextIteration
	end
end

class AskAct
	def initialize
		@act_on = Hash.new
		@rescue = Hash.new
		@histories = Array.new
		@loop = LoopControl.new
		@built_ins = {
			'history' => {
				description: 'List the entered commands you have given',
			},
			'list' => {
				description: 'List all built in commands',
			},
			'exit' => {
				description: 'Quit this REPL',
			},
			'stop' => {
				description: 'Quit this REPL',
			},
			'quit' => {
				description: 'Quit this REPL',
			},
		}
	end
	
	def ask(&block)
		@ask = block
		self
	end
	
	def act(&block)
		@act = block
		self
	end
	
	def on(name, description=nil, &block)
		@act_on[name] = {
			description: description,
			block: block
		}
		self
	end
	
	def rescue(e, &block)
		@rescue[e] = block
		self
	end
	
	def run
		while true
			begin
				begin
					input = @ask.call
					@histories << input
				rescue Exception => e
					do_rescue(e.class)
				end
				do_act(input)
			rescue NextIteration
				next
			rescue StopIteration
				break
			end
		end
		self
	end
	
	private
	
	def do_act(value)
		if @act_on.key?(value)
			@act_on[value][:block].call(@loop)
		elsif @built_ins.key?(value)
			send(value)
		else
			@act.call(value, @loop)
		end
	end
	
	def do_rescue(e)
		if @rescue.key? e
			@rescue[e].call(@loop)
		else
			raise e
		end
	end
	
	def history
		@histories.each {|h| puts h }
	end
	
	def list
		puts "Command  Description"
		puts "-------  -----------"
		(@built_ins.merge(@act_on)).compact.each { |name,details| puts "#{name.to_s}\t #{details[:description]}" }
	end
	
	def exit
		@loop.break;
	end
	
	def stop
		@loop.break;
	end
	
	def quit
		@loop.break;
	end
end
