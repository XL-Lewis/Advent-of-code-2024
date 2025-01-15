text = File.read("data.txt")

regex = /mul\([0-9]+,[0-9]+\)+/
capture = text.scan(regex)
val = 0
capture.each do |mul|
  numbers = mul[4..-2].split(",").map(&:to_i)
  val += numbers[0] * numbers[1]
end
puts val