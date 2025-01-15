def get_index(arr, x, y)
  return 'Z' if y >= arr.length || x >= arr[0].length || x < 0 || y < 0

  arr[y][x]
end

def search_right(arr, x, y)
  m = get_index arr, x + 1, y
  a = get_index arr, x + 2, y
  s = get_index arr, x + 3, y
  puts "#{x} #{y} - #{__method__}" if m == 'M' && a == 'A' && s == 'S'
  m == 'M' && a == 'A' && s == 'S' ? true : false
end

def search_left(arr, x, y)
  m = get_index arr, x - 1, y
  a = get_index arr, x - 2, y
  s = get_index arr, x - 3, y
  m == 'M' && a == 'A' && s == 'S' ? true : false
end

def search_up(arr, x, y)
  m = get_index arr, x, y - 1
  a = get_index arr, x, y - 2
  s = get_index arr, x, y - 3
  m == 'M' && a == 'A' && s == 'S' ? true : false
end

def search_down(arr, x, y)
  m = get_index arr, x, y + 1
  a = get_index arr, x, y + 2
  s = get_index arr, x, y + 3
  m == 'M' && a == 'A' && s == 'S' ? true : false
end

def search_down_right(arr, x, y)
  m = get_index arr, x + 1, y + 1
  a = get_index arr, x + 2, y + 2
  s = get_index arr, x + 3, y + 3
  puts "#{x} #{y} - #{__method__}" if m == 'M' && a == 'A' && s == 'S'
  m == 'M' && a == 'A' && s == 'S' ? true : false
end

def search_up_right(arr, x, y)
  m = get_index arr, x + 1, y - 1
  a = get_index arr, x + 2, y - 2
  s = get_index arr, x + 3, y - 3
  puts "#{x} #{y} - #{__method__}" if m == 'M' && a == 'A' && s == 'S'
  m == 'M' && a == 'A' && s == 'S' ? true : false
end

def search_down_left(arr, x, y)
  m = get_index arr, x - 1, y + 1
  a = get_index arr, x - 2, y + 2
  s = get_index arr, x - 3, y + 3
  puts "#{x} #{y} - #{__method__} #{get_index arr, x - 1, y + 1}" if m == 'M' && a == 'A' && s == 'S'
  m == 'M' && a == 'A' && s == 'S' ? true : false
end

def search_up_left(arr, x, y)
  m = get_index arr, x - 1, y - 1
  a = get_index arr, x - 2, y - 2
  s = get_index arr, x - 3, y - 3
  puts "#{x} #{y} - #{__method__}" if m == 'M' && a == 'A' && s == 'S'
  m == 'M' && a == 'A' && s == 'S' ? true : false
end

def search(arr)
  total = 0
  vertical_height = arr.length
  horizontal_width = arr[0].length
  puts vertical_height
  puts horizontal_width
  y = 0
  while y < vertical_height
    x = 0
    while x < horizontal_width
      if arr[y][x] == 'X'
        total += 1 if search_right arr,       x, y
        total += 1 if search_left arr,        x, y
        total += 1 if search_up arr,          x, y
        total += 1 if search_down arr,        x, y
        total += 1 if search_up_left arr,     x, y
        total += 1 if search_up_right arr,    x, y
        total += 1 if search_down_left arr,   x, y
        total += 1 if search_down_right arr,  x, y
      end
      x += 1
    end
    y += 1
  end
  total
end

text = File.readlines('data.txt')

test_arr = %w[XMAS XMAS XMAS XMAS]
puts search text
# 2497 - too high
