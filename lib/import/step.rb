
module Import
  class Step < Vacuum::Step

    #
    # Cache a database connection.
    #
    def initialize
      super
      @DB = self.class.DB
    end

    #
    # Connect to the legacy database.
    #
    # @return [Sequel::Database]
    #
    def self.DB

      # Read legacy params from Rails config.
      params = Rails.configuration.database_configuration["legacy"]

      Sequel.connect(
        :adapter => "postgres",
        **params.symbolize_keys
      )

    end

  end
end
