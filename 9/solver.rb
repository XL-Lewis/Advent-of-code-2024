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

file.each do |line|
  disk = populate_file(line)
  # disk.each { |v| print v }
  # puts
  arranged_disk = organize_disk disk
  # arranged_disk.each { |v| print v }
  # puts

  sum = 0
  arranged_disk.each_with_index do |val, index|
    break if val == '.'

    sum += val.to_i * index
    # puts "Multiplying #{val} by #{index} = #{val.to_i * index} (sum = #{sum})"
  end
  puts sum
end

# 6518886897209 too low
