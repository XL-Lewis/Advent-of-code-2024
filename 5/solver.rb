# some sort of tree structure?
# Hash with placements?
rules = []
arrays = []

file = File.open('data.txt')
line = file.readline

until line == "\n"
  rules.push(line.split('|').map(&:to_i))

  line = file.gets
end

line = file.gets

until line.nil?
  arrays.push(line.split(',').map(&:to_i))

  line = file.gets

end

def check_manual(rules, manual)
  position_map = {}
  # Index each manual by position
  manual.each_with_index do |val, i|
    position_map[val] = i
  end

  rules.each do |rule|
    next unless position_map.include?(rule[0]) && position_map.include?(rule[1])
    # print "\n"
    # print "Checking #{rule} against #{manual} . . ."

    if position_map[rule[0]] > position_map[rule[1]]
      # print "Invalid"
      return false
    end
    # print "Valid"
  end
  true
end

middle_manual_sum = 0
arrays.each do |manual|
  # Check each rule is followed in the manual
  puts "Checking Manual: #{manual}"
  if check_manual(rules, manual)
    puts "#{manual[manual.length / 2 + 1]}"
    middle_manual_sum += manual[manual.length / 2]
  end
  # puts "Man: #{manual} - is #{check_manual(rules, position_map)}"
end

puts middle_manual_sum

# 102 too low - 5558 too high
