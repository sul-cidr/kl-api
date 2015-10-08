
module Vacuum
  class Step

    #
    # By default, no dependencies.
    #
    def self.depends
      @depends || []
    end

    #
    # Generate a slug for the step.
    #
    # @return [String]
    #
    def slug
      self.class.name.demodulize
    end

    #
    # How many items will the step process?
    #
    # @return [Integer]
    #
    def count
      nil
    end

    #
    # Increment the progress bar.
    #
    def increment
      @bar.increment!
    end

    #
    # Run the step.
    #
    def up
      raise NotImplementedError
    end

    #
    # Revert the step.
    #
    def down
      raise NotImplementedError
    end

    #
    # Print satisfied.
    #
    def puts_satisfied
      puts "SATISFIED: #{slug}".colorize(:light_white)
    end

    #
    # Print importing.
    #
    def puts_importing
      puts "IMPORTING: #{slug}".colorize(:green)
    end

    #
    # Print reverting.
    #
    def puts_reverting
      puts "REVERTING: #{slug}".colorize(:green)
    end

    #
    # (Meta) run the step.
    #
    def _up

      if count
        @bar = ProgressBar.new(count)
      end

      if ImportStep.satisfied?(slug)
        puts_satisfied
      else
        down
        puts_importing
        up
        ImportStep.up(slug)
      end

    end

    #
    # (Meta) revert the step.
    #
    def _down

      if ImportStep.satisfied?(slug)
        puts_reverting
        down
        ImportStep.down(slug)
      else
        puts_satisfied
      end

    end

  end
end
