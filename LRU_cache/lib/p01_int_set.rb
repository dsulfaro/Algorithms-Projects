class MaxIntSet
  def initialize(max)
    @store = Array.new(max+1){false}
    @max = max
  end

  def insert(num)
    is_valid?(num)

    @store[num] = true
  end

  def remove(num)
    is_valid?(num)

    @store[num] = false
  end

  def include?(num)
    is_valid?(num)

    @store[num] == true
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' if num > @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num if !self.include?(num)
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    self[num] << num if !self.include?(num)
    @count += 1
    resize! if @count > num_buckets
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |arr|
      arr.each do |el|
        new_store[el % (num_buckets * 2)] << el
      end
    end
    @store = new_store
  end
end
