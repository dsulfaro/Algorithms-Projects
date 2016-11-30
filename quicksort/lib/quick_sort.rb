require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    partition = array.pop
    left = array.select { |x| x <= partition }
    right = array.select { |y| y > partition }
    Quicksort.sort1(left) + [partition] + Quicksort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if length <= 1
    pi = partition(array, start, length, &prc)
    length_left = pi - start
    length_right = length - (length_left + 1)
    QuickSort.sort2!(array, start, length_left, &prc)
    QuickSort.sort2!(array, pi + 1, length_right, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    pivot_idx = start
    pivot = array[start]
    i = start + 1
    while i < start + length
      # if element is smaller than pivot
      if prc.call(pivot, array[i]) == 1
        swap = array[i]
        array[i] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        array[pivot_idx] = swap
        pivot_idx += 1
      end
      i += 1
    end
    pivot_idx
  end

end
