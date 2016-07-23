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
  attr_reader :head,:tail
  def initialize
    @tail = Link.new
    @head = Link.new
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
    # @head.next.nil?
    @head.next == @tail || @tail.prev == @head
  end

  def get(key)
    node = get_node(key).nil? ? nil : get_node(key).val
  end

  def get_node(key)
    current_node = first
    until current_node.nil?
      return current_node if current_node.key == key
      current_node = current_node.next
    end
    nil
  end


  def include?(key)
    !get_node(key).nil?
  end

  def insert(key, val)
    new_ele = Link.new(key,val)
    last.next = new_ele
    new_ele.prev = last
    @tail.prev = new_ele
    new_ele.next = @tail
    # new_ele.prev = self.last
    # last.next = new_ele
    # @tail.prev = new_ele
    # new_ele.next = @tail
    #@tail.prev = new_ele

  end

  def remove(key)
    node_delete = get_node(key)
    node_delete_prev = node_delete.prev
    node_delete_next = node_delete.next
    node_delete_prev.next = node_delete_next
    node_delete_next.prev = node_delete_prev
  end

  def each
    current_node = first
    until current_node == @tail
      yield(current_node)
      current_node = current_node.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
