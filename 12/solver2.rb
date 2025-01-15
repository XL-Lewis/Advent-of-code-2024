# frozen_string_literal: true

file = File.readlines('test.txt')
file.each(&:chop!)

def get(file, row, col)
  return nil if row.negative? || col.negative?

  file[row][col] if !file[row].nil? && !file[row][col].nil?
end

def find_regions(file)
  regions = []
  seen = Set.new
  file.each_with_index do |row, row_i|
    row.chars.each_with_index do |_col, col_i|
      # puts "CHECKING #{col_i}, #{row_i}"
      next if seen.include? [row_i, col_i]

      seen.add([row_i, col_i])
      region = flood_fill(file, row_i, col_i, seen)
      next unless region.length.positive?

      # puts region.inspect
      regions.push(region)

      # if we've already checked this square - skip
      # otherwise, create a new region and flood fill to find the whole thing
    end
  end
  regions
end

def is_valid?(file, row, col, seen)
  return false if get(file, row, col).nil?

  return false if seen.include? [row, col]

  true
end

def check_fences(file, row, col)
  edges = Set.new
  edges.add(:north) if get(file, row - 1, col) != file[row][col]
  edges.add(:south) if get(file, row + 1, col) != file[row][col]
  edges.add(:east) if get(file, row, col + 1) != file[row][col]
  edges.add(:west) if get(file, row, col - 1) != file[row][col]

  edges
end

def flood_fill(file, row, col, seen)
  region = Set.new
  check_queue = [[row, col]]
  region.add([row, col])
  while check_queue.length.positive?
    crow, ccol = check_queue.shift
    # puts "Current pos: #{crow}, #{ccol}"

    directions = [[crow - 1, ccol], [crow + 1, ccol], [crow, ccol - 1], [crow, ccol + 1]]
    directions.each do |coord|
      thisrow, thiscol = coord
      # puts "checking #{coord} - isvalid: #{is_valid?(file, thisrow, thiscol,
      # seen)} #{get(file, thisrow, thiscol)} - #{file[row][col]}"

      next unless is_valid?(file, thisrow, thiscol, seen) && file[row][col] == file[thisrow][thiscol]

      # puts "adding #{thisrow} #{thiscol}"
      seen.add([thisrow, thiscol])
      region.add [thisrow, thiscol]
      check_queue.push([thisrow, thiscol])
    end
  end
  region
end

sum = 0
regions = find_regions(file)

regions.each do |region|
  region.each do |plot|
    puts "REGION: #{file[plot[0]][plot[1]]} ---------------------"
    break
  end
  region_fences = { north: {}, south: {}, east: {}, west: {} }
  region.each do |plot|
    fence_directions = check_fences(file, plot[0], plot[1])

    fence_directions.each do |dir|
      case dir
      when :north
        region_fences[dir][plot[0]] = [] if region_fences[dir][plot[0]].nil?
        region_fences[dir][plot[0]].push plot[1]

      when :south
        region_fences[dir][plot[0]] = [] if region_fences[dir][plot[0]].nil?
        region_fences[dir][plot[0]].push plot[1]
      when :east
        region_fences[dir][plot[1]] = [] if region_fences[dir][plot[1]].nil?
        region_fences[dir][plot[1]].push plot[0]
      when :west
        region_fences[dir][plot[1]] = [] if region_fences[dir][plot[1]].nil?
        region_fences[dir][plot[1]].push plot[0]

      end
    end

    # puts "Region: #{region_fences} "
  end
  region_sum = 0
  region_fences.each_value do |dir|
    # puts region_fences.inspect

    # puts "NEW DIR #{dir}"

    dir.each_value do |points|
      points.sort!
      this_sum = 1

      puts "POINT #{points}"
      i = 1

      while i < points.length
        puts "comparing    [#{i}], #{points[i]} to [#{i - 1}] #{points[i - 1] + 1} "
        this_sum += 1 if points[i] != points[i - 1] + 1
        i += 1
      end
      puts "adding #{this_sum}"
      region_sum += this_sum
    end
  end
  puts "This region sum: #{region_sum}"
  sum += region_sum * region.length
  # puts 'NEXT REGION'
end
puts sum
