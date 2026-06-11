print "How many scores? "
count = gets.chomp.to_i
if count <= 0
  puts "Invalid count. Please enter a positive number."
  exit
end

scores = []
count.times do |i|
  print "Enter score #{i + 1}: "
  score = gets.chomp.to_f
  if score < 0 || score > 100
    puts "Invalid score. Please enter a score between 0 and 100."
    redo
  end
  scores << score
end

average = scores.sum / count

grade = if average >= 90 then "A"
        elsif average >= 80 then "B"
        elsif average >= 70 then "C"
        elsif average >= 60 then "D"
        else "F"
        end

puts
puts "Results:"
puts "  Average : #{average}"
puts "  Grade   : #{grade}"
puts "  Highest : #{scores.max.to_i}"
puts "  Lowest  : #{scores.min.to_i}"
