require 'chunky_png'
require_relative 'median_cut'

MAX_SIZE = 256

filename = ARGV[0] || 'nordic_colors_256.png'
palette_size = ARGV[1].to_i || 16
palette_filename = "#{filename}_palette_#{palette_size}.png"

puts "loading #{filename} ..."
image = ChunkyPNG::Image.from_file(filename)

if image.height > MAX_SIZE or image.width > MAX_SIZE
  puts "image too large, resampling..."
  image = image.resample_bilinear(MAX_SIZE, MAX_SIZE)
end

points = image.pixels.map do |p|
  Point.new ChunkyPNG::Color.r(p), ChunkyPNG::Color.g(p), ChunkyPNG::Color.b(p)
end
palette = MedianCut.perform(points, palette_size)
swatch_size = 16
palette_example = ChunkyPNG::Image.new(swatch_size*palette_size, swatch_size, ChunkyPNG::Color::TRANSPARENT)
palette.each_with_index do |p, i|
  swatch_size.times do |x|
    swatch_size.times do |y|
      palette_example[i*swatch_size + x, y] = ChunkyPNG::Color.rgb(p.x, p.y, p.z)
    end
  end
end
puts "saving palette example: #{palette_filename}"
palette_example.save(palette_filename)

puts palette.map { |point| "#%02x%02x%02x" % [point[0], point[1], point[2]] }
