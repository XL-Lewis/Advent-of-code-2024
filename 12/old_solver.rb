# frozen_string_literal: true

file = File.readlines('test.txt')
file.each(&:chop!)

def get(file, line, char)
  return nil if line.negative? || char.negative?

  file[line][char] if !file[line].nil? && !file[line][char].nil?
end

def get_areas(file)
  plants = {}
  file.each do |line|
    line.chars.each do |char|
      plants[char] = [0, 0] unless plants.key? char
      plants[char][0] += 1
    end
  end
  plants
end

def get_borders(file, plants)
  file.each_with_index do |line, y|
    line.chars.each_with_index do |char, x|
      counter = 0
      up = get(file, y - 1, x)
      down = get(file, y + 1, x)
      left = get(file, y, x - 1)
      right = get(file, y, x + 1)
      puts "Char: #{char} up #{up} left #{left} down #{down} right #{right}"
      counter += 1 if up.nil?
      counter += 1 if left.nil?
      if down != char
        plants[down][1] += 1 unless down.nil?
        counter += 1
      end
      if right != char
        plants[right][1] += 1 unless right.nil?
        counter += 1
      end
      plants[char][1] += counter
    end
  end
  plants
end

def get_costs(plants)
  cost = 0
  plants.each do |plant|
    puts "#{plant} - #{plant[1][0] * plant[1][1]}"
    cost += plant[1][0] * plant[1][1]
  end
  cost
end

plants = get_areas file
plants = get_borders file, plants
puts get_costs plants
