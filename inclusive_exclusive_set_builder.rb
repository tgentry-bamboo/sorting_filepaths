require 'optparse'
require 'pry'
require 'pp'

class InputCollection
	def self.from_command_line
		options = Hash.new

		OptionParser.new do |op|
			op.banner = "Takes two collections and returns the inclusive and exclusive sets"

			op.on('-l', '--left=LEFT', 'Left hand set') do |set|
				options[:left] = set
			end

			op.on('-r', '--right=RIGHT', 'Right hand set') do |set|
				options[:right] = set
			end
		end.parse!

		options
	end
end

class InclusiveExclusiveSetBuilder
	def initialize(left, right)
		@left = left
		@right = right
	end

	def left_lines
		@left.split("\n").uniq # Newline characters MUST be double quoted
	end

	def right_lines
		@right.split("\n").uniq
	end

	def combined
		(left_lines << right_lines).flatten
	end

	def similar?
		combined.count - combined.uniq.count > 0
	end

	def inclusive_set
		left_lines & right_lines
	end

	def exclusive_left
		exclusive = left_lines.collect do |line| 
			if !inclusive_set.include? line
				line
			end
		end.compact
	end

	def exclusive_right
		exclusive = right_lines.collect do |line| 
			if !inclusive_set.include? line
				line
			end
		end.compact
	end
end

