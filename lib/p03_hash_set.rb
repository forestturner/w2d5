require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    #p @count
    #p "num_buckets= #{num_buckets}"
    if @count > 0 && @count == num_buckets
      @count = 0
      resize!
    end
      self[num] << num
      @count += 1
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? { |el| el == num }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    #@count = 0
    temp = num_buckets
    num_buckets.times { @store << [] }
    temp.times do |index|
      temp_length = self[index].length
      temp_length.times { insert(self[index].pop) }
    end
  end
end




#   def insert(key)
#   end
#
#   def include?(key)
#   end
#
#   def remove(key)
#   end
#
#   private
#
#   def [](num)
#     # optional but useful; return the bucket corresponding to `num`
#   end
#
#   def num_buckets
#     @store.length
#   end
#
#   def resize!
#   end
# end
