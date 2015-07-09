
require "tsort"

module Import
  class Graph < Hash

    include TSort

    alias tsort_each_node each_key

    def tsort_each_child(node, &block)
      self[node].each(&block)
    end

  end
end
