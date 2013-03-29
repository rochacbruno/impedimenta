# This module contains classes used for creating binary search trees.
module Tree
    # Can be used to construct binary search trees. For TreeNode to work, the
    # data stored in each node *must* be comparable with the <tt><=></tt>
    # operator.
    class TreeNode
        # The new +TreeNode+ holds +data+ and has children of +nil+.
        def initialize(data)
            @data = data
            @left = nil
            @right = nil
        end

        # +data+ is the arbitrary piece of data that this +TreeNode+ holds.
        # +left+ and +right+ are references to other +TreeNode+ nodes.
        #
        # +attr_accessor+ is a Ruby-ism that produces readers and writers
        # (getters and setters) all of it's arguments. For example,
        # <tt>attr_accessor :foo</tt> produces the following:
        #
        #     def foo; @foo; end
        #     def foo=(other); @foo = other; end
        #
        # Note that all class instance variables are private. You must define
        # methods in order to touch those variables.
        attr_accessor(:data, :left, :right)

        # Adds +data+ to this node or one of it's subtrees.
        def add(data)
            # Note that it's possible to assign the result of a +case+
            # expression to a variable, just as it's possible to assign the
            # result of an if/elsif/else expression to a variable. For example,
            # the following will assign 9 to +result+:
            #
            #     result = case 3
            #     when 2; 4
            #     when 3; 9
            #     else 9001
            #     end
            #
            case data <=> @data
            when -1
                if nil == @left
                    @left = TreeNode.new(data)
                else
                    @left.add(data)
                end
            when 0
                @data = data
            when 1
                if nil == @right
                    @right = TreeNode.new(data)
                else
                    @right.add(data)
                end
            end
        end

        # Returns true if +data+ is in this node or one of it's subtrees.
        def search(data)
            case data <=> @data
            when -1
                if nil == @left
                    return false
                else
                    return @left.search(data)
                end
            when 0
                return true
            when 1
                if nil == @right
                    return false
                else
                    return @right.search(data)
                end
            end
        end

        # Returns a string representing an in-order traversal of this node and
        # it's subtrees.
        def to_str
            if nil == @left and nil == @right
                return "%s" % [@data]
            elsif nil == @left and nil != @right
                return "%s, %s" % [@data, @right.to_str]
            elsif nil != @left and nil == @right
                return "%s, %s" % [@left.to_str, @data]
            else
                return "%s, %s, %s" % [@left.to_str, @data, @right.to_str]
            end
        end

        # Returns a string representing a pre-order traversal of this node and
        # it's subtrees.
        #--
        # Anything placed after a -- is not parsed by rdoc. You can re-enable
        # parsing with a ++. The fourth +return+ statement below is split out
        # onto multiple lines so as to be no more than 80 characters long.
        def to_str_pre
            if nil == @left and nil == @right
                return "%s" % [@data]
            elsif nil == @left and nil != @right
                return "%s, %s" % [@data, @right.to_str_pre]
            elsif nil != @left and nil == @right
                return "%s, %s" % [@data, @left.to_str_pre]
            else
                return "%s, %s, %s" %
                    [@data, @left.to_str_pre, @right.to_str_pre]
            end
        end

        # Returns a string representing a post-order traversal of this node and
        # it's subtrees.
        def to_str_post
            if nil == @left and nil == @right
                return "%s" % [@data]
            elsif nil == @left and nil != @right
                return "%s, %s" % [@right.to_str_post, @data]
            elsif nil != @left and nil == @right
                return "%s, %s" % [@left.to_str_post, @data]
            else
                return "%s, %s, %s" %
                    [@left.to_str_post, @right.to_str_post, @data]
            end
        end
    end

    # Allows you to create binary search trees. The data to be stored in the
    # tree *must* be comparable with the <tt><=></tt> operator, or else +Tree+
    # will malfunction.
    #
    # +Tree+ extends +TreeNode+ and offers little additional functionality.
    # Indeed, the only obvious benefit provided by +Tree+ is the ability to
    # create an empty tree. However, tree provides a foundation for adding
    # additional functionality (such as adding a delete method) or creating,
    # say, an AVL tree.
    class Tree
        # Creates an empty tree.
        def initialize
            @root = nil;
        end

        # Creates a tree whose root contains +data+.
        def initialize(data)
            @root = TreeNode.new(data)
        end

        # The root node of the tree.
        attr_accessor :root

        # Adds +data+ to an appropriate spot in the tree.
        def add(data)
            if nil == @root
                @root = TreeNode.new(data)
            else
                @root.add(data)
            end
        end

        # Returns true if the tree contains +data+. Else, returns false.
        def search(data)
            if nil == @root
                return false
            else 
                return @root.search(data)
            end
        end

        # Returns a string representing an in-order traversal of the tree.
        def to_str
            if nil == @root
                return ""
            else
                return @root.to_str
            end
        end

        # Returns a string representing a pre-order traversal of the tree.
        def to_str_pre
            if nil == @root
                return ""
            else
                return @root.to_str_pre
            end
        end

        # Returns a string representing a post-order traversal of the tree.
        def to_str_post
            if nil == @root
                return ""
            else
                return @root.to_str_post
            end
        end
    end
end
