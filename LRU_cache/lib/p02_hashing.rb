class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty?
    total = self.first.hash
    self[1..-1].each do |el|
      total -= el.hash
    end
    total
  end
end

class String
  def hash
    self.split("").map{ |letter| letter.ord }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    values = self.values.sort
    keys = self.keys.map{:to_s}.sort
    values.concat(keys).join("").hash
  end
end
