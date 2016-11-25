require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(0)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length || @length == 0
    @store[(@start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index >= length || @length == 0
    @store[(@start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    popped = @store[(@start_idx + (@length - 1)) % @capacity]
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    self.resize! if @length == @capacity
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    shifted = @store[@start_idx]
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    self.resize! if @capacity == @length
    @store[(@start_idx - 1) % @capacity] = val
    @length += 1
    @start_idx = (@start_idx - 1) % @capacity
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    return false if index > @capacity
    true
  end

  def resize!
    cap = @capacity * 2
    new_store = StaticArray.new(cap)
    @length.times { |i| new_store[i] = self[i] }
    @capacity = cap
    @store = new_store
    @start_idx = 0
  end
end
