require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(0)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length || @length == 0
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index >= length || @length == 0
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    new_store = StaticArray.new(@capacity)
    @length.times do |i|
      next if i == 0
      new_store[i] = @store[i]
    end
    @store = new_store
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.resize! if @capacity == @length
    new_store = StaticArray.new(@capacity)
    new_store[0] = val
    @length.times { |i| new_store[i + 1] = @store[i] }
    @store = new_store
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    return false if index > @capacity
    true
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    @length.times { |i| new_store[i] = @store[i] }
    @store = new_store
  end
end
