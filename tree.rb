# frozen_string_literal: true

require_relative 'node'

class Tree
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
end
