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

rules_hash = {}
rules.each do |rule|
  if rules_hash.key? rule[0]
    rules_hash[rule[0]].push rule[1]
  else
    rules_hash[rule[0]] = [rule[1]]
  end
end

puts rules_hash
line = file.gets

until line.nil?
  arrays.push(line.split(',').map(&:to_i))

  line = file.gets

end

# Returns true if manual 1 should be in front of manual 2
def compare_manual(rules_hash, manual1, manual2)
  return false unless rules_hash.key? manual1

  rules_hash[manual1].include? manual2
end

def sort_manual(rules_hash, manuals)
  unsorted = true

  while unsorted
    # puts "Loop: #{manuals}"
    unsorted = false
    i = 1
    while i < manuals.length
      # puts "comparing #{manuals[i]} #{rules_hash[manuals[i]]} to #{manuals[i - 1]}"
      if compare_manual(rules_hash, manuals[i], manuals[i - 1])
        # puts "Swapping #{manuals[i]} with #{manuals[i - 1]}"
        buffer = manuals[i]
        manuals[i] = manuals[i - 1]
        manuals[i - 1] = buffer
        unsorted = true
      end
      i += 1

    end
  end
end

# def fix_invalids(_invalid_nums, _manual)
#   ordered_nums = []
# end
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
# def check_manual(rules, manual)
#   position_map = {}
#   # Index each manual by position
#   manual.each_with_index do |val, i|
#     position_map[val] = i
#   end

#   invalid_nums = {}
#   rules.each do |rule|
#     next unless position_map.include?(rule[0]) && position_map.include?(rule[1])

#     # print "\n"
#     # print "Checking #{rule} against #{manual} . . ."

#     next unless position_map[rule[0]] > position_map[rule[1]]

#     # print "Invalid"
#     invalid_nums[rule[0]] = position_map[rule[0]]
#     invalid_nums[rule[1]] = position_map[rule[1]]
#     # print "Valid"
#   end
#   #   invalid_places = fix_invalids(invalid_nums, manual)
# end
middle_manual_sum = 0
arrays.each do |manual|
  next if check_manual rules, manual

  sort_manual rules_hash, manual
  # puts additive
  middle_manual_sum += manual[manual.length / 2]
  # puts manual.inspect
end

puts middle_manual_sum

# # 102 too low - 5558 too high
# 4201 - 9755
