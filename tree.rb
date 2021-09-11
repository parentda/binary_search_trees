# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(clean_array(array))
  end

  def build_tree(array)
    return if array.empty?

    mid_index = (array.size - 1) / 2
    node = Node.new(array[mid_index])

    node.left = build_tree(array.slice(0...mid_index))
    node.right = build_tree(array.slice(mid_index + 1..-1))

    node
  end

  def clean_array(array)
    array.sort.uniq
  end

  def insert(value); end

  def delete(value); end

  def find(value); end

  def level_order
    output = []
    queue = [] << @root

    until queue.empty?
      node = queue.shift
      output << node.data
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end

    output
  end

  def inorder(output = nil); end

  def preorder(output = nil); end

  def postorder(output = nil); end

  def height(node); end

  def depth(node); end

  def balanced?; end

  def rebalance; end

  def pretty_print(node = @root, prefix = '', is_left = true)
    if node.right
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false)
    end
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    if node.left
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true)
    end
  end
end
