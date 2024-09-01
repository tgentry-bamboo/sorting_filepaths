require_relative 'inclusive_exclusive_set_builder.rb'

class Runner
	def self.run
		options = InputCollection.from_command_line # OptionParser implicitely ingests ARGV and transforms into a Hash
		InclusiveExclusiveSetBuilder.new options[:left], options[:right] # Completes my Jira ticket
	end
end

sets = Runner.run

puts "\nInclusive set:"
sets.inclusive_set.each { |l| puts l }
puts "\nExclusive left set:"
sets.exclusive_left.each { |l| puts l }
puts "\nExclusive right set:"
sets.exclusive_right.each { |l| puts l }

