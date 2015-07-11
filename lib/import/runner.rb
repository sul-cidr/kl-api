
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

      # Add step to up/down adjacency lists.
      @udeps[step] = []
      @ddeps[step] = []

      # Register up/down dependencies.
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
    # Resolve dependencies and run all steps.
    #
    def up
      @udeps.tsort_each do |dep|
        step_up(dep.new)
      end
    end

    #
    # Roll back an import step, including all downsteam steps that depend on
    # the root step.
    #
    # @param name [String]
    #
    def down(name)
      @ddeps.each_strongly_connected_component_from(@steps[name]) do |cmp|
        cmp.each do |dep|
          step_down(dep.new)
        end
      end
    end

    #
    # Run an individual step.
    #
    # @param step [Import::Step]
    #
    def step_up(step)
      if step.satisfied?
        puts "SATISFIED: #{step.class.name}".colorize(:light_white)
      else
        puts "IMPORTING: #{step.class.name}".colorize(:green)
        step.up
      end
    end

    #
    # Revert an individual step.
    #
    # @param step [Import::Step]
    #
    def step_down(step)
      if step.satisfied?
        puts "REVERTING: #{step.class.name}".colorize(:green)
        step.down
      else
        puts "SATISFIED: #{step.class.name}".colorize(:light_white)
      end
    end

  end
end
