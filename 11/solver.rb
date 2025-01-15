# frozen_string_literal: true

line = File.open('data.txt').readline.split(' ')

$even = proc { |val| val.length.even? }
$cache = {}

def recurse_value(val, iterations, count)
  # puts val
  if iterations == 75
    count += 1
    return count
  end
  iterations += 1

  cached_count = $cache[[val, iterations]]
  return cached_count unless cached_count.nil?

  # puts iterations

  case val
  when '0'
    # puts '1'
    $cache[[val, iterations]] = recurse_value '1', iterations, count
  when $even
    # puts val[0...val.length / 2]
    # puts [val.length / 2..val.length - 1]
    total = recurse_value val[0...val.length / 2], iterations, count
    total += recurse_value val [val.length / 2..val.length - 1].to_i.to_s, iterations, count
    $cache[[val, iterations]] = total

  else
    $cache[[val, iterations]] = recurse_value (val.to_i * 2024).to_s, iterations, count
  end
end

total = 0
line.each do |val|
  counter = recurse_value val, 0, 0
  total += counter
  puts "Starting cell value: #{val}, Total Final Cells: #{counter}"
end
# puts $cache
puts total

# 404701 too low
