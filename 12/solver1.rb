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
  directions = [[row - 1, col], [row + 1, col], [row, col - 1], [row, col + 1]]
  sum = 0
  directions.each do |direction|
    crow, ccol = direction
    # puts "checking [#{row} #{col}] #{file[row][col]} against [#{crow} #{ccol}] #{get(file, crow, ccol)}"

    val = get(file, crow, ccol)

    sum += 1 if val != file[row][col]
  end
  sum
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
  region_fences = { north: [], south: [], east: [], west: [] }
  region.each do |plot|
    fence_directions = check_fences(file, plot[0], plot[1])

    fence_directions.each do |dir|
      # puts fence_directions
      region_fences[dir].push plot
    end
    # puts "Region: #{region_fences} "
  end
  # puts region_fences.inspect
end
# puts sum
