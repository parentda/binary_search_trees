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

    if value < node.data
      node.left = insert_recursive(value, node.left)
    elsif value > node.data
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
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      node.data = min_node(node.right).data

      node.right = delete_recursive(node.data, node.right)
    end

    node
  end

  def min_node(node = @root)
    node = node.left until node.left.nil?
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

  def height(node = @root)
    return 0 if node.nil? || (node.left.nil? && node.right.nil?)

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node = nil, root = @root)
    return if node.nil?
    return 0 if node.data == root.data

    if node.data < root.data
      depth(node, root.left) + 1
    else
      depth(node, root.right) + 1
    end
  end

  def balanced?
    return true if @root.nil?

    queue = [] << @root
    min_level = Float::INFINITY
    max_level = -Float::INFINITY
    curr_level = 0

    until queue.empty?
      element_count = queue.size
      until element_count.zero?
        node = queue.shift
        if node.left.nil? && node.right.nil?
          min_level = curr_level if min_level > curr_level
          max_level = curr_level if max_level < curr_level
        else
          queue << node.left unless node.left.nil?
          queue << node.right unless node.right.nil?
        end
        element_count -= 1
      end
      if max_level.integer? && min_level.integer? &&
           (max_level - min_level).abs > 1
        return false
      end

      curr_level += 1
    end

    true
  end

  def balanced_recursive?(node = @root)
    balanced_recursive_helper(node) != -1
  end

  def balanced_recursive_helper(node = @root)
    return 0 if node.nil?

    left_height = balanced_recursive_helper(node.left)
    return -1 if left_height == -1

    right_height = balanced_recursive_helper(node.right)
    return -1 if right_height == -1

    return -1 if (left_height - right_height).abs > 1

    [left_height, right_height].max + 1
  end

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
  Tree.new(
    [
      1,
      7,
      4,
      23,
      8,
      9,
      4,
      3,
      5,
      7,
      9,
      67,
      6345,
      324,
      2,
      0,
      10,
      6,
      6.5,
      1000,
      10_000,
      -1
    ]
  )
