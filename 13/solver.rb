file = File.readlines('data.txt')
file.each(&:chop!)

def get_equations(file)
  i = 0
  j = 0
  eqtns = []
  while i < file.length
    eqtn1 = file[i].scan(/\d+/).map(&:to_f)
    eqtn2 = file[i + 1].scan(/\d+/).map(&:to_f)
    eqtn3 = file[i + 2].scan(/\d+/).map(&:to_f).map { |val| val + 10_000_000_000_000 }

    eqtns[j] = [[eqtn1[0], eqtn2[0]], [eqtn1[1], eqtn2[1]], eqtn3]
    i += 4
    j += 1
  end
  eqtns
end

def get_determinant(eqtn)
  # puts eqtn.inspect
  det = eqtn[0][0] * eqtn[1][1] - eqtn[0][1] * eqtn[1][0]
  # puts det
  return det if det != 0

  nil?
end

def solve_equation(eqtn, det)
  inverse = [[eqtn[1][1], -eqtn[0][1]], [-eqtn[1][0], eqtn[0][0]]]
  x = (inverse[0][0] * eqtn[2][0] + inverse[0][1] * eqtn[2][1]) * 1 / det
  y = (inverse[1][0] * eqtn[2][0] + inverse[1][1] * eqtn[2][1]) * 1 / det
  return nil if x % 1 != 0 || y % 1 != 0

  [x.to_i, y.to_i]
end

def calculate_tokens_used(x, y)
  3 * x + y
end
sum = 0
eqtns = get_equations(file)
eqtns.each do |eqtn|
  print "\n---\nStarting equation #{eqtn} . . . "
  det = get_determinant(eqtn)
  next if det.nil?

  print "det = #{det}"
  x, y = solve_equation(eqtn, det)
  next if x.nil? || y.nil?

  print "\nResults = #{x}, #{y} "

  sum += calculate_tokens_used(x, y)
  print "& Adding #{calculate_tokens_used(x, y)} - Sum now = #{sum}"
end
puts
puts sum

# 35887 too low
