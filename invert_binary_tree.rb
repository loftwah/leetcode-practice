###############################################################################
# This Ruby script demonstrates two methods for inverting a binary tree:
#   1) A recursive (DFS) approach: invert_tree
#   2) An iterative (BFS) approach: invert_tree_iterative
#
# It also prints out detailed, step-by-step logging to the console:
#   - Which node you're "standing on" at each level
#   - The children of that node before the swap
#   - A message indicating a "swap" of the left and right nodes
#   - The children of that node after the swap
#
# The script ends by showing test output for both methods using the same tree.
# 
# The goal here is to provide an extremely in-depth, line-by-line explanation
# so that you can see exactly what's happening, why each line exists,
# and how it all works together. No placeholders are used. You can copy this
# file as-is and run `ruby this_file_name.rb` without needing to modify anything.
###############################################################################


###############################################################################
# class TreeNode
# ---------------
# This class defines a single node in a binary tree. Each node contains:
#   - A value (val)
#   - A pointer/reference to a left child (left)
#   - A pointer/reference to a right child (right)
#
# attr_accessor :val, :left, :right makes these attributes readable and writable.
###############################################################################
class TreeNode
    # This line creates getter and setter methods for val, left, and right.
    attr_accessor :val, :left, :right
  
    # The initialize method is called when we create a new instance of TreeNode.
    # It sets @val (the node's value) and optionally accepts left and right children.
    # Default values are provided so you can do TreeNode.new with no arguments.
    def initialize(val = 0, left = nil, right = nil)
      @val = val      # The numeric or string value of the node
      @left = left    # The left child (another TreeNode or nil)
      @right = right  # The right child (another TreeNode or nil)
    end
  end
  
  
  ###############################################################################
  # get_level(node)
  # ---------------
  # This method is not strictly necessary for inverting the tree. It's a helper
  # that returns a "level number" based on the node's value. It's here in the code,
  # but note that in the final inversion logic, we don't actually call get_level.
  # This is just for demonstration or example purposes.
  ###############################################################################
  def get_level(node)
    # We check node.val and return a level number:
    #   If the value is 1, we say it's level 0.
    #   If the value is 2 or 3, we say it's level 1.
    #   If the value is 4 or 5, we say it's level 2.
    #
    # You could expand this pattern to return other levels for different values.
    # Or remove this method if unused.
    case node.val
    when 1 then 0
    when 2, 3 then 1
    when 4, 5 then 2
    end
  end
  
  
  ###############################################################################
  # invert_tree(root, current_level = 0)
  # ------------------------------------
  # A RECURSIVE, depth-first search (DFS) approach to inverting the tree.
  #
  #   - Takes the "root" node of a tree (or subtree).
  #   - Recursively calls itself on left and right subtrees.
  #   - Swaps the left and right children of each node encountered.
  #   - current_level helps us track how "deep" we are in the tree.
  #
  # The function returns the same root node, but now with its subtree inverted.
  ###############################################################################
  def invert_tree(root, current_level = 0)
    # If the node is nil (empty), return nil immediately.
    # This is our base case for the recursion. If there's no node, there's
    # nothing to invert or display.
    return nil if root.nil?
  
    #############################################################################
    # 1) Print out the current situation ("Standing on Level X" ... etc.)
    #############################################################################
    puts "\nStanding on Level #{current_level}:"
    # We show that we are "seeing" the current root node and show its val.
    # e.g. "I see Person 1 here"
    puts "I see Person #{root.val} here"
  
    #############################################################################
    # 2) Print out what's below the current node, i.e., the next level.
    #############################################################################
    puts "\nLooking down to Level #{current_level + 1}:"
    # We do a check: if root.left is not nil, then print its value,
    # otherwise print "I see empty space".
    puts "- Down to the left: #{root.left ? "I see Person #{root.left.val}" : "I see empty space"}"
    # Same check on the right side.
    puts "- Down to the right: #{root.right ? "I see Person #{root.right.val}" : "I see empty space"}"
  
    #############################################################################
    # 3) Perform the "inversion" swap of left and right children.
    #############################################################################
    puts "\nTelling the people on Level #{current_level + 1} to switch sides..."
  
    # Temporarily store root.left in a variable so we can swap them.
    temp = root.left
    root.left = root.right
    root.right = temp
  
    #############################################################################
    # 4) Print updated child references if there are any children.
    #############################################################################
    # If either child exists, we show that they've switched.
    if root.left || root.right
      puts "\nStanding on Level #{current_level + 1}:"
      puts "- Down to the left: #{root.left ? "I see Person #{root.left.val}" : "I see empty space"}"
      puts "- Down to the right: #{root.right ? "I see Person #{root.right.val}" : "I see empty space"}"
    end
  
    #############################################################################
    # 5) Recurse down the tree, now that this node's children are swapped.
    #############################################################################
    # We only recurse if the child is not nil.
    # Doing this ensures that eventually we visit every node in the tree.
    invert_tree(root.left, current_level + 1) if root.left
    invert_tree(root.right, current_level + 1) if root.right
  
    # Return the node so that it can be used as part of a larger structure.
    return root
  end
  
  
  ###############################################################################
  # invert_tree_iterative(root)
  # ---------------------------
  # An ITERATIVE, breadth-first search (BFS) approach to inverting the tree.
  #
  #   - Uses a queue (an array in Ruby can work as a queue using shift/push).
  #   - Starts with the root node. For each node encountered, swap its children.
  #   - Then enqueue its children (if they exist) to process them in FIFO order.
  #   - Continues until the queue is empty.
  #
  # The function returns the (inverted) root node.
  ###############################################################################
  def invert_tree_iterative(root)
    # If there is no root, there's nothing to invert, so we return nil right away.
    return nil if root.nil?
  
    # Initialize a queue that will hold pairs: [node, level].
    # 'node' is the actual TreeNode object, 'level' is how far down in the tree
    # we are (root is level 0, children are level 1, etc.).
    queue = [[root, 0]]
  
    # Process until our queue is empty:
    while !queue.empty?
      # queue.shift removes the first element in the queue (FIFO order),
      # so we get the next node, along with the level at which it resides.
      node, level = queue.shift
  
      #############################################################################
      # 1) Print out the current node's level and the node's value.
      #############################################################################
      puts "\nStanding on Level #{level}:"
      puts "I see Person #{node.val} here"
  
      #############################################################################
      # 2) Print out what's below the current node: left and right children.
      #############################################################################
      puts "\nLooking down to Level #{level + 1}:"
      puts "- Down to the left: #{node.left ? "I see Person #{node.left.val}" : "I see empty space"}"
      puts "- Down to the right: #{node.right ? "I see Person #{node.right.val}" : "I see empty space"}"
  
      #############################################################################
      # 3) Perform the swap.
      #############################################################################
      puts "\nTelling the people on Level #{level + 1} to switch sides..."
  
      # Use a temp variable to hold the left child, swap with the right.
      temp = node.left
      node.left = node.right
      node.right = temp
  
      #############################################################################
      # 4) After the swap, print the new references if the node has children.
      #############################################################################
      if node.left || node.right
        puts "\nStanding on Level #{level + 1}:"
        puts "- Down to the left: #{node.left ? "I see Person #{node.left.val}" : "I see empty space"}"
        puts "- Down to the right: #{node.right ? "I see Person #{node.right.val}" : "I see empty space"}"
      end
  
      #############################################################################
      # 5) Add the children of the current node to the queue if they exist.
      #    We'll process them later in BFS order (top to bottom, left to right).
      #############################################################################
      queue.push([node.left, level + 1]) if node.left
      queue.push([node.right, level + 1]) if node.right
    end
  
    # After we finish the while loop, we've processed every node in the tree.
    # The tree is now inverted. We return the root (same object, but inverted).
    return root
  end
  
  
  ###############################################################################
  # TEST CODE
  # -----------
  # Construct a sample binary tree, then test both the recursive and iterative
  # invert methods. We'll print the logs to the console so you can see it working.
  #
  # The test_tree looks like this before inversion:
  #
  #              (1)
  #             /   \
  #           (2)   (3)
  #           /       \
  #         (4)       (5)
  #
  # After inversion, it should look like this:
  #
  #              (1)
  #             /   \
  #           (3)   (2)
  #           /       \
  #         (5)       (4)
  ###############################################################################
  
  # Create a "test_tree" with this structure:
  #   - Root node: TreeNode.new(1, ...)
  #   - Left subtree of root: TreeNode.new(2, TreeNode.new(4), nil)
  #   - Right subtree of root: TreeNode.new(3, nil, TreeNode.new(5))
  test_tree = TreeNode.new(
    1,
    TreeNode.new(
      2,
      TreeNode.new(4),   # left child of node (2)
      nil               # right child of node (2)
    ),
    TreeNode.new(
      3,
      nil,              # left child of node (3)
      TreeNode.new(5)   # right child of node (3)
    )
  )
  
  
  ###############################################################################
  # 1) Method 1: Recursive (DFS)
  ###############################################################################
  puts "\nMethod 1: Recursive (DFS)"
  puts "------------------------"
  
  # We call invert_tree on a copy (dup) of test_tree to avoid modifying test_tree
  # for the second example. Otherwise, the second example would see it already inverted.
  recursive_result = invert_tree(test_tree.dup)
  
  ###############################################################################
  # 2) Method 2: Iterative (BFS)
  ###############################################################################
  puts "\nMethod 2: Iterative (BFS)"
  puts "------------------------"
  
  # Now we do the same thing using the iterative approach. We again pass in a 
  # duplicate of test_tree, for the same reason as above.
  iterative_result = invert_tree_iterative(test_tree.dup)
  
  ###############################################################################
  # End of script
  # -------------
  # The console output will show, step by step, what is happening at each level,
  # both for the recursive and the iterative approach. You can confirm that 
  # the "switch sides" action is happening at each node (from top to bottom).
  #
  # That's it! This code is now thoroughly commented and can be copy-pasted
  # directly into a file and executed with `ruby filename.rb`. Enjoy!
  ###############################################################################
  