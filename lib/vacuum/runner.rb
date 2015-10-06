
require_rel './graph'

module Vacuum
  class Runner

    attr_accessor :steps, :udeps, :ddeps

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
    # Initialize the up/down dependency graphs.
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

      # Initialize up/down adjacency lists.
      @udeps[step] = [] unless @udeps.has_key?(step)
      @ddeps[step] = [] unless @ddeps.has_key?(step)

      # Register dependencies.
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
    # Run all steps.
    #
    # @param name [String]
    #
    def up(name=nil)

      # Import to a specific step, if one is passed.
      if name
        @udeps.each_strongly_connected_component_from(@steps[name]) do |cmp|
          cmp.each do |dep|
            dep.new.up
          end
        end

      # Otherwise, run all steps.
      else
        @udeps.tsort_each do |dep|
          dep.new.up
        end
      end

    end

    #
    # Roll back an import step.
    #
    # @param name [String]
    #
    def down(name=nil)

      # Revert to a specific step, if one is passed.
      if name
        @ddeps.each_strongly_connected_component_from(@steps[name]) do |cmp|
          cmp.each do |dep|
            dep.new.down
          end
        end

      # Otherwise, revert all steps.
      else
        @ddeps.tsort_each do |dep|
          dep.new.down
        end
      end

    end

  end
end
