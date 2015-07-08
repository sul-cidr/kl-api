
module Import
  class Runner

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
    # Initialize the step map.
    #
    def initialize
      @steps = {}
    end

    #
    # Register an import step.
    #
    # @param step [Import::Step]
    #
    def add_step(step)
      @steps[step.name] = step
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
