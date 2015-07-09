
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
      @udeps = Graph.new([])
      @ddeps = Graph.new([])
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
    # Run import steps. If a step name is passed, run just that step.
    # Otherwise, run all steps.
    #
    # @param name [String]
    #
    def up(name=nil)
      if name
        @steps[name].new.up
      else
        @steps.each do |k, step|
          step.new.up
        end
      end
    end

    #
    # Roll back an import step.
    #
    # @param name [String]
    #
    def down(name)
      @steps[name].new.down
    end

  end
end
