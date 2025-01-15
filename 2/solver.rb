def check_level(arr)
  # puts "INIT ARRAY: #{arr}"
  # For every combination of array where one value is deleted
  arr.combination(arr.length - 1).each do |subarr|
    asc_valid = true
    desc_valid = true

    # Check if ascending
    0.upto(subarr.length - 2) do |i|
      asc_valid = false unless check_two(subarr[i], subarr[i + 1])
    end
    # Check if ascending (in reverse aka descending)
    (subarr.length - 1).downto(1) do |i|
      desc_valid = false unless check_two(subarr[i], subarr[i - 1])
    end
    # puts "#{subarr} - Asc #{asc_valid}, Desc #{desc_valid}"
    # If we get a valid combo, return immediately
    return true if asc_valid || desc_valid
  end
  # If we get to the end, we know every combo is invalid
  false
end

def check_two(smaller, bigger)
  return false if smaller > bigger
  return false unless (bigger - smaller).abs.between?(1, 3)

  true
end

safe = 0
File.foreach('data.txt') do |line|
  level = line.split(' ').map(&:to_i)

  safe += 1 if check_level(level)
end

puts safe
