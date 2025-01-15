file = File.readlines('data.txt')
file.each_with_index do |line, index|
  puts "#{index} - #{line.index('^')}" if line.include? '^'
end

$current_pos = [53, 91]
$current_dir = 0

def move(arr)
  # return if arr[$current_pos[0]][$current_pos[1]].nil?

  positions = %i[north east south west]

  next_move = nil
  $current_dir -= 4 if $current_dir > 3
  $current_dir += 4 if $current_dir < 0

  case positions[$current_dir]
  when :north
    next_move = [$current_pos[0] - 1, $current_pos[1]]
  when :east
    next_move = [$current_pos[0], $current_pos[1] - 1]
  when :south
    next_move = [$current_pos[0] + 1, $current_pos[1]]
  when :west
    next_move = [$current_pos[0], $current_pos[1] + 1]
  end

  if arr[next_move[0]][next_move[1]] == '#'
    $current_dir -= 1
    return
  end
  arr[$current_pos[0]][$current_pos[1]] = 'X'

  $current_pos = next_move

  # puts "#{arr[$current_pos[0]][$current_pos[1]]} - #{$current_dir}"
  nil
end

# At each movement position, try place an object there and start from the beginning
# If that causes us to end up back at the same spot with an identical direction to previous iterations, we know we're in a loop

file[$current_pos[0]][$current_pos[1]] = 'X'

i = 0
while !file[$current_pos[0]].nil? && !file[$current_pos[0]][$current_pos[1]].nil?
  move file
  i += 1
end

total_distinct_positions = 0
for line in file
  total_distinct_positions += line.count('X')
end

puts file
puts total_distinct_positions - 1
