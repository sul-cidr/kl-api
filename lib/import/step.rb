
module Import
  class Step

    class << self
      attr_accessor :depends
    end

    @depends = []

    #
    # Set the database connection, initialize the progress bar.
    #
    def initialize

      @DB = Helpers::Legacy.DB

      if count
        @bar = ProgressBar.new(count)
      end

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
    # Run the import.
    #
    def up
      raise NotImplementedError
    end

    #
    # Reverse the import.
    #
    def down
      raise NotImplementedError
    end

    #
    # Has the import been run?
    #
    # @return [Boolean]
    #
    def satisfied?
      raise NotImplementedError
    end

  end
end
