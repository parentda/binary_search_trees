# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array); end

  def insert(value); end

  def delete(value); end

  def find(value); end

  def level_order; end

  def inorder; end

  def preorder; end

  def postorder; end

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
