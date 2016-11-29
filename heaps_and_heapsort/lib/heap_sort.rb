require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    # heapify array
    while self.length > 0
      heap.push(self.shift)
    end
    sorted = []
    # pop off heap elements into array
    while heap.count > 0
      self << heap.extract
    end
  end
end
