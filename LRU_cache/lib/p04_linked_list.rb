
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each{|link| return link.val if link.key == key}
    nil
  end

  def include?(key)
    any?{|e| e.key == key}
  end

  def insert(key, val)
    each{|e| return e.val = val if e.key == key}
      new_link = Link.new(key, val)
      @tail.prev.next = new_link
      new_link.prev = @tail.prev
      @tail.prev = new_link
      new_link.next = @tail
      return new_link
  end

  def remove(key)
    iterator = iterate(key)
    return nil if iterator == -1
    iterator.prev.next = iterator.next
    iterator.next.prev = iterator.prev
  end

  def each
    iterator = @head.next
    until iterator == @tail
      yield(iterator)
      iterator = iterator.next
    end
  end
  
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private

  def iterate(key)
    return -1 if self.empty?
    iterator = @head.next
    until iterator.key == key
      iterator = iterator.next
      return -1 if iterator.nil?
    end
    iterator
  end
end
