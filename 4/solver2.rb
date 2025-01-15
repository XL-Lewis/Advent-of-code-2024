def get_index(arr, x, y)
  return 'Z' if y >= arr.length || x >= arr[0].length || x < 0 || y < 0

  arr[y][x]
end

def search_top_m(arr, x, y)
  tl = get_index arr, x - 1, y - 1
  tr = get_index arr, x + 1, y - 1
  bl = get_index arr, x - 1, y + 1
  br = get_index arr, x + 1, y + 1
  true if tl == 'M' && tr == 'M' && bl == 'S' && br == 'S'
end

def search_bot_m(arr, x, y)
  tl = get_index arr, x - 1, y - 1
  tr = get_index arr, x + 1, y - 1
  bl = get_index arr, x - 1, y + 1
  br = get_index arr, x + 1, y + 1
  true if tl == 'S' && tr == 'S' && bl == 'M' && br == 'M'
end

def search_right_m(arr, x, y)
  tl = get_index arr, x - 1, y - 1
  tr = get_index arr, x + 1, y - 1
  bl = get_index arr, x - 1, y + 1
  br = get_index arr, x + 1, y + 1
  true if tl == 'S' && tr == 'M' && bl == 'S' && br == 'M'
end

def search_left_m(arr, x, y)
  tl = get_index arr, x - 1, y - 1
  tr = get_index arr, x + 1, y - 1
  bl = get_index arr, x - 1, y + 1
  br = get_index arr, x + 1, y + 1
  true if tl == 'M' && tr == 'S' && bl == 'M' && br == 'S'
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
      if get_index(arr, x, y) == 'A'
        total += 1 if search_top_m arr,   x, y
        total += 1 if search_bot_m arr,   x, y
        total += 1 if search_left_m arr,  x, y
        total += 1 if search_right_m arr, x, y
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
