
require "tsort"

module Import
  class Graph < Hash

    include TSort

    #
    # Return an empty array when a key is absent.
    #
    # @param key [Import::Step]
    #
    def default(key=nil)
      []
    end

    #
    # Expose keys as nodes.
    #
    alias tsort_each_node each_key

    #
    # Expose each class in the value arrays as a child node.
    #
    # @param node [Import::Step]
    #
    def tsort_each_child(node, &block)
      self[node].each(&block)
    end

  end
end
