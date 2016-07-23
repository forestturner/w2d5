class Fixnum
  # Fixnum#hash already implemented for you

end

# class Array
#   def hash
#
#     sum = 0
#     self.flatten.each_with_index { |el, index| sum += (el * index) }
#     sum.hash
#   end
# end

class String
  def hash
    int_array = self.split("").map { |el| el.ord }
    int_array.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_array = self.sort.flatten.map {|el| el.to_s.hash }
    hash_array.hash
  end
end
