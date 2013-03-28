#!/usr/bin/env ruby

# "This will automatically discover your Gemfile, and make all of the gems in
# your Gemfile available to Ruby." See a full explanation
# {here}[http://gembundler.com/v1.3/rationale.html].
require 'rubygems'
require 'bundler/setup'

# External deps.
require 'test/unit'
# Internal deps.
require_relative 'Tree'

# Unit tests for class +TreeNode+ in module +Tree+.
class TestTreeNode < Test::Unit::TestCase
    # Ensure a single node can be created with correct defaults and that it's
    # accessor methods work correctly.
    def test_one_node
        # Does a +TreeNode+ have correct defaults?
        node = Tree::TreeNode.new(10)
        assert_equal 10, node.data
        assert_equal nil, node.left
        assert_equal nil, node.right

        # Can you store something other than integers?
        node = Tree::TreeNode.new("blargh")
        assert_equal "blargh", node.data
        assert_equal nil, node.left
        assert_equal nil, node.right

        # Can it be written to?
        node.data = "arbitrary"
        node.left = "data"
        node.right = 9001
        assert_equal "arbitrary", node.data
        assert_equal "data", node.left
        assert_equal 9001, node.right
    end

    # Creates several three-node trees and ensures they link correctly. Tests
    # +add+ and the various +to_str+ methods.
    def test_three_nodes
        # Create a balanced, three-node tree. First add the root node...
        node = Tree::TreeNode.new(10)
        assert_equal nil, node.left
        assert_equal 10, node.data
        assert_equal nil, node.right
        assert_equal "10", node.to_str
        assert_equal "10", node.to_str_pre
        assert_equal "10", node.to_str_post
        # ... then add the left node...
        node.add 9
        assert_equal 9, node.left.data
        assert_equal 10, node.data
        assert_equal nil, node.right
        assert_equal "9, 10", node.to_str
        assert_equal "10, 9", node.to_str_pre
        assert_equal "9, 10", node.to_str_post
        # ... and finally, the right node.
        node.add 11
        assert_equal 9, node.left.data
        assert_equal 10, node.data
        assert_equal 11, node.right.data
        assert_equal "9, 10, 11", node.to_str
        assert_equal "10, 9, 11", node.to_str_pre
        assert_equal "9, 11, 10", node.to_str_post

        # Create a left-leaning tree.
        node = Tree::TreeNode.new(10)
        node.add 9
        node.add 8
        assert_equal "8, 9, 10", node.to_str
        assert_equal "10, 9, 8", node.to_str_pre
        assert_equal "8, 9, 10", node.to_str_post

        # Create a right-leaning tree.
        node = Tree::TreeNode.new(10)
        node.add 11
        node.add 12
        assert_equal "10, 11, 12", node.to_str
        assert_equal "10, 11, 12", node.to_str_pre
        assert_equal "12, 11, 10", node.to_str_post
    end
	
	# Creates a tree with several nodes. Tests the +search+ method.
	def test_search
		# Create a tree with 7 nodes
		node = Tree::TreeNode.new(50)
		node.add 25
		node.add 75
		node.add 20
		node.add 30
		node.add 70
		node.add 80
		# Test that +search+ can find all the nodes in the tree
		assert_equal true, node.search(50)
		assert_equal true, node.search(25)
		assert_equal true, node.search(75)
		assert_equal true, node.search(20)
		assert_equal true, node.search(30)
		assert_equal true, node.search(70)
		assert_equal true, node.search(80)
		
		# Test that +search+ doesn't find nodes that aren't in the tree
		assert_equal false, node.search(-50)
		assert_equal false, node.search(49)
		assert_equal false, node.search(51)
		assert_equal false, node.search(24)
		assert_equal false, node.search(26)
		assert_equal false, node.search(74)
		assert_equal false, node.search(76)
		assert_equal false, node.search(19)
		assert_equal false, node.search(21)
		assert_equal false, node.search(29)
		assert_equal false, node.search(31)
		assert_equal false, node.search(69)
		assert_equal false, node.search(71)
		assert_equal false, node.search(79)
		assert_equal false, node.search(81)
		
		
	end
end

# Unit tests for class +Tree+ in module +Tree+.
class TestTree < Test::Unit::TestCase
    # Ensure a single-node +Tree+ can be created with correct defaults and that
    # it's accessor methods work correctly.
    def test_one_node
        # does a default node behave sanely?
        tree = Tree::Tree.new(10)
        assert_equal 10, tree.root.data
        assert_equal nil, tree.root.left
        assert_equal nil, tree.root.right

        # can it be written to?
        tree.root.data = 20
        tree.root.left = 30
        tree.root.right = 40
        assert_equal 20, tree.root.data
        assert_equal 30, tree.root.left
        assert_equal 40, tree.root.right

        # can you store something other than integers?
        tree = Tree::Tree.new("blargh")
        assert_equal "blargh", tree.root.data
        assert_equal nil, tree.root.left
        assert_equal nil, tree.root.right
    end

    # Creates several three-node trees and ensures they link correctly. Tests
    # +add+ and the various +to_str+ methods.
    def test_three_nodes
        # Create a balanced, three-node tree. First add the root node...
        tree = Tree::Tree.new(10)
        assert_equal nil, tree.root.left
        assert_equal 10, tree.root.data
        assert_equal nil, tree.root.right
        assert_equal "10", tree.to_str
        assert_equal "10", tree.to_str_pre
        assert_equal "10", tree.to_str_post
        # ... then add the left node...
        tree.add 9
        assert_equal 9, tree.root.left.data
        assert_equal 10, tree.root.data
        assert_equal nil, tree.root.right
        assert_equal "9, 10", tree.to_str
        assert_equal "10, 9", tree.to_str_pre
        assert_equal "9, 10", tree.to_str_post
        # ... and finally, the right node.
        tree.add 11
        assert_equal 9, tree.root.left.data
        assert_equal 10, tree.root.data
        assert_equal 11, tree.root.right.data
        assert_equal "9, 10, 11", tree.to_str
        assert_equal "10, 9, 11", tree.to_str_pre
        assert_equal "9, 11, 10", tree.to_str_post

        # Create a left-leaning tree.
        tree = Tree::Tree.new(10)
        tree.add 9
        tree.add 8
        assert_equal "8, 9, 10", tree.to_str
        assert_equal "10, 9, 8", tree.to_str_pre
        assert_equal "8, 9, 10", tree.to_str_post

        # Create a right-leaning tree.
        tree = Tree::Tree.new(10)
        tree.add 11
        tree.add 12
        assert_equal "10, 11, 12", tree.to_str
        assert_equal "10, 11, 12", tree.to_str_pre
        assert_equal "12, 11, 10", tree.to_str_post
    end
	
	# Creates a tree with several nodes. Tests the +search+ method.
	def test_search
		# Create a tree with 7 nodes
		tree = Tree::Tree.new(50)
		tree.add 25
		tree.add 75
		tree.add 20
		tree.add 30
		tree.add 70
		tree.add 80
		# Test that +search+ can find all the nodes in the tree
		assert_equal true, tree.search(50)
		assert_equal true, tree.search(25)
		assert_equal true, tree.search(75)
		assert_equal true, tree.search(20)
		assert_equal true, tree.search(30)
		assert_equal true, tree.search(70)
		assert_equal true, tree.search(80)
		
		# Test that +search+ doesn't find nodes that aren't in the tree
		assert_equal false, tree.search(-50)
		assert_equal false, tree.search(49)
		assert_equal false, tree.search(51)
		assert_equal false, tree.search(24)
		assert_equal false, tree.search(26)
		assert_equal false, tree.search(74)
		assert_equal false, tree.search(76)
		assert_equal false, tree.search(19)
		assert_equal false, tree.search(21)
		assert_equal false, tree.search(29)
		assert_equal false, tree.search(31)
		assert_equal false, tree.search(69)
		assert_equal false, tree.search(71)
		assert_equal false, tree.search(79)
		assert_equal false, tree.search(81)
		
		
	end
end
