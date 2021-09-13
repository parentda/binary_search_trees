# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array = [])
    @root = build_tree(clean_array(array))
  end

  def build_tree(array)
    return if array.empty?

    mid_index = (array.size - 1) / 2
    node = Node.new(array[mid_index])

    node.left = build_tree(array.slice(0...mid_index))
    node.right = build_tree(array.slice((mid_index + 1)..-1))

    node
  end

  def clean_array(array)
    array.sort.uniq
  end

  def insert(value)
    @root = insert_recursive(value)
  end

  def insert_recursive(value, node = @root)
    return Node.new(value) if node.nil?
    return node if node.data == value

    if value < node.data
      node.left = insert_recursive(value, node.left)
    else
      node.right = insert_recursive(value, node.right)
    end

    node
  end

  def delete(value)
    @root = delete_recursive(value)
  end

  def delete_recursive(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete_recursive(value, node.left)
    elsif value > node.data
      node.right = delete_recursive(value, node.right)
    else
      if node.left.nil?
        temp = node.right
        node = nil
        return temp
      elsif node.right.nil?
        temp = node.left
        node = nil
        return temp
      end
    end

    node
  end

  def find(value, node = @root)
    return if node.nil?
    return node if node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

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

  def inorder(node = @root, output = [])
    return if node.nil?

    inorder(node.left, output)
    output << node.data
    inorder(node.right, output)

    output
  end

  def preorder(node = @root, output = [])
    return if node.nil?

    output << node.data
    preorder(node.left, output)
    preorder(node.right, output)

    output
  end

  def postorder(node = @root, output = [])
    return if node.nil?

    postorder(node.left, output)
    postorder(node.right, output)
    output << node.data

    output
  end

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

@tree =
  Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 2, 0, 10, 6, 6.5])
