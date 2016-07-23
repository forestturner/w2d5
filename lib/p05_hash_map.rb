require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    !get(key).nil?
  end

  def set(key, val)
    if @count > 0 && @count == @store.length
      resize!
    end
    if include?(key)
      delete(key)
    end
      get_bucket(key).insert(key,val)
      @count += 1
  end

  def get(key)
    get_bucket(key).get(key)
  end

  def get_bucket(key)
    @store[bucket_index(key)]
  end

  def bucket_index(key)
    key.hash % @store.length
  end

  def delete(key)
    get_bucket(key).remove(key)
    @count -= 1
  end

  def each
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hashmap = HashMap.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each do |link|
        new_hashmap.set(link.key,link.val)
      end
    end
    @store = new_hashmap.store
  end
    # temp = num_buckets
    # num_buckets.times { @store << LinkedList.new }
    # temp.times do |index|
    #   temp_length = self[index].length
    #   temp_length.times do |index|
    #
    #
    # end
  # end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
