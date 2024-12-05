
def check_level arr
  #puts "INIT ARRAY: #{arr}"
  # For every combination of array where one value is deleted
  arr.combination(arr.length-1).each do |subarr|  
    asc_valid = true
    desc_valid = true

    # Check if ascending
    0.upto(subarr.length-2){|i|
      asc_valid = false if !check_two subarr[i], subarr[i+1]
    }   
    # Check if ascending (in reverse aka descending)
    (subarr.length-1).downto(1){|i|
      desc_valid = false if !check_two subarr[i], subarr[i-1]
    }
    #puts "#{subarr} - Asc #{asc_valid}, Desc #{desc_valid}"
    # If we get a valid combo, return immediately
    return true if asc_valid || desc_valid
  end
  # If we get to the end, we know every combo is invalid 
  return false
end

def check_two smaller, bigger
  return false if smaller > bigger
  return false if !(bigger - smaller).abs().between?(1,3)
  return true
end

safe = 0
File.foreach("data.txt") { |line|
  level = line.split(" ").map(&:to_i)

  safe += 1 if check_level(level)

}

puts safe