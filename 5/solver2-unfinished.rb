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

while !line.nil?
    arrays.push(line.split(',').map(&:to_i))

    line = file.gets

end

def fix_invalids(invalid_nums, manual)
    ordered_nums = []
    
end

def check_manual(rules, manual)

    position_map = {}
    # Index each manual by position
    manual.each_with_index {|val, i|
        position_map[val] = i
    }

    invalid_nums = {}
    rules.each {|rule|
        if position_map.include?(rule[0]) && position_map.include?(rule[1])
            #print "\n"
            #print "Checking #{rule} against #{manual} . . ."

            if position_map[rule[0]] > position_map[rule[1]] 
                #print "Invalid"
                invalid_nums[rule[0]] = position_map[rule[0]]
                invalid_nums[rule[1]] = position_map[rule[1]]
            end
            #print "Valid"
        end
    }
    invalid_places = fix_invalids(invalid_nums, manual)
end

middle_manual_sum = 0
arrays.each { |manual|

    # Check each rule is followed in the manual
    #puts "Checking Manual: #{manual}"
    if check_manual(rules, manual)
        #puts "#{manual[manual.length/2 + 1]}"
        middle_manual_sum += manual[manual.length/2]
    end
    #puts "Man: #{manual} - is #{check_manual(rules, position_map)}"
}

puts middle_manual_sum

# 102 too low - 5558 too high