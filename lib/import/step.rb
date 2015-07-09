
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

      # Read KB1 params from Rails config.
      params = Rails.configuration.database_configuration['legacy']

      @DB = Sequel.connect(
        :adapter => "postgres",
        **params.symbolize_keys
      )

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
