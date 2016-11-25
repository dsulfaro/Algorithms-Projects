require_relative 'p02_hashing'
require_relative 'p04_linked_list'


require 'byebug'
class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)

    bucket(key).include?(key)
  end

  def set(key, val)
    bucket(key).insert(key, val)
    @count += 1
    resize! if @count > num_buckets
  end

  def get(key)
    return nil unless self.include?(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket = bucket(key)
    if bucket.include?(key)
      bucket(key).remove(key)
      @count -= 1
    else
      return -1
    end
  end

  def each
    @store.each do |sam|
      sam.each do |link|
        yield(link.key, link.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |list|
      next if list.first.nil?
      list.each do |link|
        new_store[link.key.hash % (num_buckets * 2)].insert(link.key, link.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
