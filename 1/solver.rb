total = 0
arr1 = []
arr2 = []
freq = {}
File.foreach('data.txt') do |line|
  v = line.split(' ')
  freq[v[0].to_i] = 0
  arr1.push v[0].to_i
  arr2.push v[1].to_i
end

arr1.sort!
arr2.sort!

for i in 0..arr1.length - 1 do
  val = arr1[i] - arr2[i]
  total += val.abs
end

arr2.each do |val|
  freq[val.to_i] += 1 if freq.has_key? val.to_i
end

frequency_total = 0

freq.each do |val|
  frequency_total += val[0] * val[1]
end

puts total
puts frequency_total
