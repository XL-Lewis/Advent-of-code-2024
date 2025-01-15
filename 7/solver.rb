file = File.readlines('data.txt')

$operators = ['+', '*', '||']

def operate(operator, total, val)
  # puts "   DOING: #{total} #{operator} #{val}"
  if operator == '+'
    total + val
  elsif operator == '*'
    total * val
  elsif operator == '||'
    (total.to_s + val.to_s).to_i
  end
end

def check_group(val, nums)
  operator_groups = $operators.repeated_permutation(nums.length - 1)
  operator_groups.each do |group|
    # puts "  Trying group: #{group}"
    total = nums[0]
    i = 1
    while i < nums.length
      total = operate(group[i - 1], total, nums[i])
      i += 1
    end
    next if total > val
    if total == val
      # puts "    Success!: #{group}"
      return true
    end
  end
  # puts "FAILED: #{nums}"
  false
end

grand_total = 0

file.each do |line|
  puts "Starting line: #{line}"
  (val, nums) = line.split(':')
  val = val.to_i
  nums = nums.split(' ').map(&:to_i)
  grand_total += val if check_group(val, nums)
end
puts grand_total

# 7019 too low - 3351424677624 too high
# 70174911051186
#
