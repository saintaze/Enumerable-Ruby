module Enumerable
  def my_each
    self.length.times { |i| yield self[i] }
  end

  def my_each_with_index 
    self.length.times { |i| yield(self[i], i) }
  end

  def my_select
    selected = []
    self.my_each { |val| selected << val if yield(val) } 
    selected
  end

  def my_all?
    self.my_each { |val| return false unless yield(val) }
    true
  end

  def my_any?
    self.my_each { |val| return true if yield(val) }
    false
  end

  def my_none?
    self.my_each { |val| return false if yield(val) }
    true
  end

  def my_count(matchVal = nil)
    return self.length unless matchVal
    self.join().scan(Regexp.new(matchVal.to_s)).length
  end

  def my_map(proc = nil, &block)
    mapped = []
    self.my_each { |val| mapped.push(proc ? proc.call(val) : block.call(val)) }
    mapped
  end

  def my_inject(acc = nil)
    curr = acc ? self[0] : self[1]
    start_index = acc ? 0 : 1
    acc = acc || self[0]
    start_index.upto(self.length - 1) {|i| acc = yield(acc, self[i])}
    acc
  end
end

class Array
  include Enumerable
end

# Test the enumerable inject method

def multiply_els(arr)
  arr.my_inject(&:*)
end
