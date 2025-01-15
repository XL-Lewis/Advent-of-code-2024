$file = File.readlines('8/data.txt')

nodes = {}
$antinodes = Set.new
$height = $file.length
$width = $file[0].length - 1 # newlines count apparently

$file.each_with_index do |line, i|
  line.chars.each_with_index do |letter, j|
    next if letter == '.' || letter == "\n"
    nodes[letter] = [] if !nodes.key?(letter)
    nodes[letter].push([j,i])
  end
end

#puts nodes

def diff_between (node_1, node_2)
  x_diff = node_1[0] - node_2[0]
  y_diff = node_1[1] - node_2[1]
  return x_diff, y_diff
end

def add_antinode antinode
  if antinode[0].between?(0,$width - 1) && antinode[1].between?(0,$height - 1)

    $antinodes.add antinode #if $file[antinode[1]][antinode[0]] == '.'
    $file[antinode[1]][antinode[0]] = '#'
  end
end

nodes.each_value do |list|
  pairs = list.combination(2).collect
  pairs.each do |pair|
    diff_x, diff_y = diff_between(pair[0], pair[1]) 
    antinode_1 = [pair[0][0]+diff_x,pair[0][1]+diff_y]
    antinode_2 = [pair[1][0]-diff_x,pair[1][1]-diff_y]
    add_antinode(antinode_1)
    add_antinode(antinode_2)
    # puts antinode_1.to_s
    # puts antinode_2.to_s
    # puts '.'
  end
  # puts list.to_s
end



#puts $antinodes
puts $antinodes.length
puts $file
# 334 - 375