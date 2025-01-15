file = File.readlines('data.txt')
file.each(&:chop!)
$height = 103
$width = 101

# $height = 7
# $width = 11

def read_robots(file)
  robots = []
  file.each do |line|
    robots.push line.scan(/-?\d+/).map(&:to_i)
  end
  robots
end

def calculate_movements(robots)
  i = 0
  while i < 100
    puts "#{i} - #{robots.inspect}"

    robots.each do |robot|
      robot[0] = robot[0] + robot[2]
      robot[1] = robot[1] + robot[3]
      robot[0] = robot[0]  % $width
      robot[1] = robot[1]  % $height
    end
    i += 1
  end
  robots
end
robots = read_robots file

robots = calculate_movements(robots)
grid = Array.new($height) { Array.new($width) }
grid.each { |line| puts line.inspect }
robots.each do |robot|
  puts robot.inspect
  if grid[robot[1]][robot[0]].nil?
    puts "New entry at #{robot[1]} #{robot[0]}"
    grid[robot[1]][robot[0]] = 1
  else

    grid[robot[1]][robot[0]] += 1
    puts "Adding at #{robot[1]} #{robot[0]} to #{grid[robot[1]][robot[0]]}"

  end
end

grid.each { |line| puts line.inspect }
quads = Array.new(4) { 0 }
puts quads
robots.each do |robot|
  if robot[1] < $height / 2  # Top quadrant
    if robot[0] < $width / 2 # Top Left
      quads[0] += 1
    elsif robot[0] > $width / 2 # Top Right
      quads[1] += 1
    end
  elsif robot[1] > $height / 2  # Bottom quadrant
    if robot[0] < $width / 2    # Bottom left
      quads[2] += 1
    elsif robot[0] > $width / 2    # Bottom Right
      quads[3] += 1
    end
  end
end

puts quads[0] * quads[1] * quads[2] * quads[3]
