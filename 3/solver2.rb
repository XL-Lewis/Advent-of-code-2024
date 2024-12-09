text = File.read("data.txt")

regex = /(mul\(\d+,\d+\)|do\(\)|don't\(\))/
capture = text.scan(regex)

puts capture
val = 0
current_state = :do

capture.each do |arr_line|
  line = arr_line[0]
  if line == "do()"
    #puts "#{line} - #{val}"
    current_state = :do
  elsif line == "don't()"
    #puts "#{line} - #{val}"
    current_state = :dont
  else
    if current_state == :do
      numbers = line[4..-2].split(",").map(&:to_i)
      val += numbers[0] * numbers[1]
    end
  end

end
puts val
# 65394941 too low