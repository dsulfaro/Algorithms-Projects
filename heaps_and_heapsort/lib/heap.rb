require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @prc = prc
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    val = @store.pop
    BinaryMinHeap::heapify_down(@store, 0)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap::heapify_up(@store, count - 1, count)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    result = []
    result << (parent_index * 2) + 1 if (parent_index * 2) + 1 < len
    result << (parent_index * 2) + 2 if (parent_index * 2) + 2 < len
    result
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)

    prc ||= Proc.new { |x, y| x <=> y }
    c1, c2 = child_indices(len, parent_idx)

    # check for existance of child first before performing comparison
    while (!c1.nil? && prc.call(array[parent_idx], array[c1]) > 0) ||
          (!c2.nil? && prc.call(array[parent_idx], array[c2]) > 0)

      # if there is no second child or the first child is smaller
      if c2.nil? || prc.call(array[c1], array[c2]) == -1
        array[c1], array[parent_idx] = array[parent_idx], array[c1]
        parent_idx = (parent_idx * 2) + 1
      else
        array[c2], array[parent_idx] = array[parent_idx], array[c2]
        parent_idx = (parent_idx * 2) + 2
      end
      c1, c2 = child_indices(len, parent_idx)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)

    return array if child_idx == 0

    prc ||= Proc.new { |x, y| x <=> y }
    par_idx = parent_index(child_idx)

    while !par_idx.nil? && prc.call(array[par_idx], array[child_idx]) > 0
      array[child_idx], array[par_idx] = array[par_idx], array[child_idx]
      child_idx = par_idx
      return array if child_idx == 0
      par_idx = parent_index(child_idx)
    end
    array
  end

end
