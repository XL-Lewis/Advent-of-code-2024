class Robot
  attr_accessor :field, :x, :y, :direction, :positions, :moves, :width, :height

  def initialize(file_path, blocker = nil)
    self.field = File.readlines(file_path, comp: true)
    self.positions = %i[north east south west]
    self.direction = 0
    field.each_with_index do |line, y|
      if line.include?('^')
        @y = y
        @x = line.index('^')
      end
    end
    self.moves = [[y, x, direction]]
    self.height = field.length
    self.width = field[0].length - 1

    return unless blocker

    field[blocker[0]][blocker[1]] = 'O'
  end

  def direction_pretty
    positions[direction]
  end

  def print_position
    puts "#{y}, #{x} - #{direction_pretty}"
  end

  def turn
    self.direction += 1
    self.direction -= 4 if @direction > 3
  end

  def move_forward
    case positions[direction]
    when :north
      self.y -= 1
    when :east
      self.x += 1
    when :south
      self.y += 1
    when :west
      self.x -= 1
    end
    return :loop_found if moves.include?([y, x, direction])

    moves << [y, x, direction]
  end

  def next_item
    local_x = self.x.clone
    local_y = self.y.clone
    case positions[direction]
    when :north
      local_y -= 1
    when :east
      local_x += 1
    when :south
      local_y += 1
    when :west
      local_x -= 1
    end
    item_at(local_y, local_x)
  end

  def item_at(local_y, local_x)
    return nil unless !field[local_y].nil? && !field[local_y][local_x].nil? && local_x >= 0 && local_y >= 0

    field[local_y][local_x]
  end

  def do_next_move
    # puts "Next item: #{next_item}"
    case next_item
    when '.', 'X', '^'
      # puts "moving from #{y}, #{x}"
      return :loop_found if move_forward == :loop_found
    when nil, "\n"
      # puts 'end of the line'
      return nil
    when '#', 'O'
      # puts "turning from #{direction_pretty}"
      turn
    end
    1
  end

  def run
    loop do
      next_move = do_next_move
      return :loop_found if next_move == :loop_found
      break if next_move.nil?
    end
    moves
  end

  def get_current_field
    local_field = field.clone.map(&:clone)
    moves.each do |move|
      local_field[move[0]][move[1]] = 'X'
    end
    local_field
  end

  def print_current_field
    get_current_field.map { |line| puts line }
  end
end

runner = Robot.new('data.txt')
runner.run
moveset = runner.moves.uniq

blockers = Set.new
moveset.each_with_index do |move, i|
  new_bot = Robot.new('data.txt', [move[0], move[1]])
  puts i
  if new_bot.run == :loop_found
    # new_bot.print_current_field
    blockers << [move[0], move[1]]
  end
end

puts blockers.uniq.length
