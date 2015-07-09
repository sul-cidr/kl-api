
module Import
  class Runner

    attr_accessor :steps

    #
    # Make an instance from a set of steps.
    #
    # @param steps [Array]
    #
    def self.from_steps(steps)
      runner = new
      runner.add_steps(steps)
      runner
    end

    #
    # Initialize the name -> class map and the up/down dependency graphs.
    #
    def initialize
      @steps = {}
      @udeps = Graph.new
      @ddeps = Graph.new
    end

    #
    # Register an import step.
    #
    # @param step [Import::Step]
    #
    def add_step(step)

      # Map name -> class.
      @steps[step.name.demodulize] = step

      # Build out up/down adjacency lists.
      step.depends.each do |dep|
        @udeps[step] += [dep]
        @ddeps[dep] += [step]
      end

    end

    #
    # Register a collection of import steps.
    #
    # @param steps [Array]
    #
    def add_steps(steps)
      steps.each do |step|
        add_step(step)
      end
    end

    #
    # Run import steps.
    #
    def up()
      @udeps.tsort_each do |dep|
        dep.new.up
      end
    end

    #
    # Roll back an import step.
    #
    # @param name [String]
    #
    def down(name)
      @ddeps.each_strongly_connected_component_from(@steps[name]) do |cmp|
        cmp.each do |dep|
          dep.new.down
        end
      end
    end

  end
end
