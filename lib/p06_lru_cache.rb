require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'
class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    #prc ||= Proc.new {|x| x ** 2 }
    @prc = prc

  end

  def count
    @map.count
  end

  def get(key)
    #p calc!(key)
    element = @map[key]
    p element
    if element
      #@map.delete(key)
      update_link!(element)
    else
      p "hi"
      new_value = calc!(key)
      update_link!( Link.new(key, new_value) )
    end
    @store.last.val
  end


  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.insert(link.key,link.val)
    @map.set(link.key,link)

    if count > @max
      eject!
    end

  end

  def eject!
    first_key = @store.first.key
    @store.remove(first_key)
    @map.delete(first_key)
  end
end
