# frozen_string_literal: true

file = File.readlines('data.txt')

def populate_file(line)
  is_file = true
  this_line = []
  i = 0
  line.chars.each do |val|
    val = val.to_i
    if is_file == true
      (0...val).each do
        this_line.push(i)
      end
      i += 1
    else
      (0...val).each do
        this_line.push('.')
      end
    end
    is_file = !is_file
  end
  this_line
end

def organize_disk(disk)
  i = disk.length - 1
  j = 0
  while j < i
    i -= 1 while disk[i] == '.'
    j += 1 while disk[j] != '.'
    # puts
    # disk.each { |v| print v }
    break if j >= i

    disk[j] = disk[i]
    disk[i] = '.'
  end
  disk
end

def find_gaps(disk)
  gaps = []
  i = 0
  j = 0
  while i < disk.length
    # puts "#{i} - #{disk[i]}"

    if disk[i] == '.'
      j = i
      counter = 0
      while j < disk.length
        # puts "i #{i}, j #{j}, #{disk[i]}, #{disk[j]}"
        break if disk[j] != '.'

        j += 1
        counter += 1
      end
      gaps.push([i, counter])
      i = j
    end

    i += 1
  end
  gaps
end

def find_blocks(disk)
  gaps = []
  i = 0
  j = 0
  while i < disk.length
    # puts "#{i} - #{disk[i]}"

    if disk[i] != '.'
      j = i
      counter = 1
      while j < disk.length
        j += 1

        # puts "i #{i}, j #{j}, #{disk[i]}, #{disk[j]}"
        break if disk[j] != disk[i]

        counter += 1
      end
      gaps.push([i, counter])
      i = j - 1
    end

    i += 1
  end
  gaps
end

def find_block_for_moving(gap, blocks)
  # puts "Searching for #{gap} in #{blocks}"
  blocks.reverse.each_with_index do |block, index|
    break if block[0] < gap[0]
    return blocks.length - index - 1 if block[1] <= gap[1]
  end
  false
end

def move_block(disk, block_index, block_size, new_index)
  # puts "Moving block of size [#{block_size}]: index #{block_index} #{disk[block_index...block_index + block_size]} to index #{new_index} #{disk[new_index...new_index + block_size]}"
  disk[new_index...new_index + block_size] = disk[block_index...block_index + block_size]
  disk[block_index...block_index + block_size] = ('.' * disk[block_index...block_index + block_size].length).chars
  # puts "Disk after moving #{disk}"
end

def allocate_gap_for_moving(block, gaps)
  # puts "Looking for block with size #{block_size} . . ."
  deletion_index = -1
  gap_index = -1

  gaps.each_with_index do |gap, index|
    next unless gap[1] >= block[1]
    return false if gap[0] > block[0]

    deletion_index = index
    gap_index = gap[0]
    break
  end
  if deletion_index != -1
    # puts "found gap big enough: #{gaps[deletion_index]}}"
    gaps[deletion_index][1] -= block[1]
    gaps[deletion_index][0] += block[1]
    gaps.delete_at(deletion_index) if gaps[deletion_index][1].zero?
    # puts "Gaps: #{gaps}"
    return gap_index
  end
  # puts 'No block found!'
  false
end

file.each do |line|
  disk = populate_file(line)
  # disk.each { |v| print v }
  # puts
  # arranged_disk = organize_disk disk
  # arranged_disk.each { |v| print v }
  # puts

  # sum = 0
  # arranged_disk.each_with_index do |val, index|
  #   break if val == '.'

  #   sum += val.to_i * index
  #   # puts "Multiplying #{val} by #{index} = #{val.to_i * index} (sum = #{sum})"
  # end
  puts "#{disk}"
  gaps = find_gaps(disk)
  blocks = find_blocks(disk)
  puts "GAPS: #{find_gaps(disk)}"
  puts "BLOCKS: #{find_blocks(disk)}"
  # gap = allocate_gap_for_moving(blocks[-3][1], gaps)
  # move_block(disk, blocks[-3][0], blocks[-3][1], gap)
  # puts "POST_MOVE BLOCKS: #{disk}"
  # puts "POST_MOVE GAPS: #{gaps}"

  # i = 0
  # while i < 3
  #   until gaps[i][1].zero?
  #     block_index = find_block_for_moving gaps[i], blocks

  #     break unless block_index

  #     move_block(disk, blocks[block_index][0], blocks[block_index][1], gaps[i][0])
  #     gaps[i][0] += blocks[block_index][1]
  #     gaps[i][1] -= blocks[block_index][1]
  #     blocks.delete_at(block_index)
  #   end
  #   i += 1
  # end
  blocks_backwards = blocks.reverse
  blocks_backwards.each do |block|
    gap = allocate_gap_for_moving block, gaps
    next unless gap

    # puts "Found gap at #{gap}"
    move_block disk, block[0], block[1], gap
  end

  puts disk.inspect
  # puts gaps.inspect
  # puts blocks.inspect

  sum = 0
  disk.each_with_index do |val, index|
    next if val == '.'

    sum += val.to_i * index
    # puts "Multiplying #{val} by #{index} = #{val.to_i * index} (sum = #{sum})"
  end
  puts sum
  puts sum.class
end

# 8800549860065 too high
# 6547228115826
# 16012157994200
