AXIS = [:x, :y, :z]
DIMENSIONS = AXIS.length
MIN = 0
MAX = 255

Point = Struct.new(*AXIS)

class Block
  attr_accessor :points, :min_corner, :max_corner, :length

  def initialize(points)
    @min_corner = Point.new(*[0]*DIMENSIONS)
    @max_corner = Point.new(*[255]*DIMENSIONS)
    @points = points
    @length = points.length
  end

  def longest_size_index
    m = @max_corner[0] - @min_corner[0]
    max_index = 0
    DIMENSIONS.times do |i|
      diff = @max_corner[i] - @min_corner[i]
      if diff > m
        m = diff
        max_index = i
      end
    end
    max_index
  end

  def longest_size_length
    i = longest_size_index
    @max_corner[i] - @min_corner[i]
  end

  def <(other)
    longest_size_length < other.longest_size_length
  end

  def shrink
    DIMENSIONS.times { |i| @min_corner[i] = @max_corner[i] = @points[0][i] }
    (0..@length-1).each do |i| # NOTE!!!
      DIMENSIONS.times do |j|
        @min_corner[j] = [@min_corner[j], @points[i][j]].min
        @max_corner[j] = [@max_corner[j], @points[i][j]].max
      end
    end
    self
  end

  def average_point
    sums = [0,0,0]
    @length.times do |i|
      DIMENSIONS.times do |d|
        sums[d] += points[i][d]
      end
    end
    Point.new *(sums.map { |x| x/length})
  end
end

class MedianCut
  def self.perform(points, palette_size)
    @queue = [Block.new(points).shrink]
    while @queue.length < palette_size and @queue[0].length > 1
      longest_block = @queue.shift
      points = longest_block.points
      color_to_split = longest_block.longest_size_index
      #puts "splitting by #{color_to_split == 0 ? 'red' : color_to_split == 1 ? 'green' : 'blue' }"
      sorted_by_color = points.sort_by { |p| p[color_to_split] }
      median_index = (longest_block.length + 1) / 2
      sorted_by_color.each_slice(median_index) do |slice|
        @queue.push(Block.new(slice).shrink)
      end
    end
    @queue.map(&:average_point)
  end
end
