# typed: true

file = File.readlines('data.txt')
$current_score = 0

def get_index(x, y, file)
  if !file[y].nil? and !file[y][x].nil?
    return -1 if x < 0 or y < 0 or x > file[y].length or y > file.length

    return file[y][x].to_i
  end

  -1
end

def search_trail(x, y, file, seen)
  current_height = file[y][x].to_i
  puts "Position: x: #{x}, y: #{y}, val: #{get_index(x, y, file)}, score: #{$current_score}" if current_height == 0

  if current_height == 9 && !seen.include?([x, y])
    $current_score += 1
    # seen.add([x,y])
    puts "Peak! x: #{x}, y: #{y}, val: #{get_index(x, y, file)}, score: #{$current_score}"
  else
    # file[y][x] = 'x'
    search_trail(x + 1, y, file.clone, seen) if get_index(x + 1, y, file) == current_height + 1
    search_trail(x - 1, y, file.clone, seen) if get_index(x - 1, y, file) == current_height + 1
    search_trail(x, y + 1, file.clone, seen) if get_index(x, y + 1, file) == current_height + 1
    search_trail(x, y - 1, file.clone, seen) if get_index(x, y - 1, file) == current_height + 1
  end
end

file.each_with_index do |line, y|
  line.each_char.with_index do |letter, x|
    seen = Set.new
    search_trail(x, y, file.clone, seen) if letter == '0'
  end
end

puts $current_score

# 621 too high
