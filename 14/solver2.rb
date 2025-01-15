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
  while i < 10_000
    array = Array.new($height) { Array.new($width, '.') }
    # puts "#{i} - #{robots.inspect}"

    robots.each do |robot|
      robot[0] = robot[0] + robot[2]
      robot[1] = robot[1] + robot[3]
      robot[0] = robot[0]  % $width
      robot[1] = robot[1]  % $height
    end

    robots.each do |robot|
      array[robot[1]][robot[0]] = 'X'
    end

    File.open('output.txt', 'a') do |file|
      file.puts i
      array.each do |row|
        file.puts row.join('') # Join each row with spaces for readability
      end
    end
    # puts i
    #    array.each { |line| puts line.inspect }
    i += 1
  end
  robots
end
robots = read_robots file

robots = calculate_movements(robots)
