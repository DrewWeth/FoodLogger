require 'rubygems'
require 'sequel'

DB = Sequel.connect('sqlite://fooddb.db')
=begin
DB.create_table :food do
	primary_key :id
	String :name
	Integer :calories
end
=end

food = DB[:food]
IOFILENAME = "fooddb.txt"

fin = File.new(IOFILENAME, "r")
foodArr = Array.new
input = ""


while line = fin.gets
	foodArr << line.strip
	puts line
end
fin.close
	
while !(input.eql?("quit")) do
	puts "--------------TEXT Logged----------------"
	puts "Number of records: #{foodArr.length}"
	foodArr.each do |i|
		puts i + "\n"
	end
	puts "-----------------------------------------"

	puts "--------------SQL Logged-----------------"
	puts "Number of records: #{food.count}"
	food.each do |r|
		puts r[:name]
	end
	puts "-----------------------------------------"

	puts "Enter food name, quit to quit, or clear to clear"
	input = gets.chomp
	if (input.eql?("clear"))
		foodArr = []
		puts "clear successful"
		# implement sql clear (either drop table or systematically)
	elsif (!(input.eql?("quit")))
		foodArr << input
		food.insert(:name => input, :calories => rand * 1000)
		puts input + " successfully logged!\n"
	end

end

output = File.open(IOFILENAME, "w" )
foodArr.each do |f|
	output << f + "\n"
end
output.close

