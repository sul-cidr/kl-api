
module Import
  class Step

    class << self
      attr_accessor :depends
    end

    @depends = []

    #
    # Set the legacy database connection.
    #
    def initialize
      @DB = Helpers::Legacy.DB
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
