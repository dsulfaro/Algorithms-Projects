require 'byebug'

class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left, @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      BinarySearchTree.insert!(@root, value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node.nil?
    if value <= node.value
      node.left.nil? ? node.left = BSTNode.new(value) :
                       BinarySearchTree.insert!(node.left, value)
    else
      node.right.nil? ? node.right = BSTNode.new(value) :
                        BinarySearchTree.insert!(node.right, value)
    end
    return node
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value
    return nil if node.left.nil? && node.right.nil?
    node.value > value ? BinarySearchTree.find!(node.left, value) :
                         BinarySearchTree.find!(node.right, value)
  end

  def self.preorder!(node)
    return [] unless node
    [node.value]
      .concat(BinarySearchTree.inorder!(node.left))
      .concat(BinarySearchTree.inorder!(node.right))
  end

  def self.inorder!(node)
    return [] unless node
    BinarySearchTree.inorder!(node.left)
      .concat([node.value])
      .concat(BinarySearchTree.inorder!(node.right))
  end

  def self.postorder!(node)
    return [] unless node
    BinarySearchTree.postorder!(node.left)
      .concat(BinarySearchTree.postorder!(node.right))
      .concat([node.value])
  end

  def self.height!(node)
    return -1 unless node
    return 0 if node.left.nil? & node.right.nil?
    [1 + BinarySearchTree.height!(node.left),
     1 + BinarySearchTree.height!(node.right)].max
  end

  def self.max(node)
    return nil unless node
    return node if node.right.nil?
    BinarySearchTree.max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node if node.left.nil?
    BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right if node.left.nil?
    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node
    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      if node.left.nil? && node.right.nil?
        node = nil
      elsif node.left.nil?
        node = node.right
      elsif node.right.nil?
        node = node.left
      else
        temp = node
        node = BinarySearchTree.min(temp.right)
        node.right = BinarySearchTree.delete_min!(temp.right)
        node.left = temp.left
      end
      node
    end
  end
end
