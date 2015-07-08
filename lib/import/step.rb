
module Import
  class Step

    class << self
      attr_accessor :depends
    end

    @depends = []

    # Set the legacy database connection.
    def initialize

      # Read KB1 params from Rails config.
      params = Rails.configuration.database_configuration['legacy']

      @DB = Sequel.connect(
        :adapter => "postgres",
        **params.symbolize_keys
      )

    end

    # Run the import.
    def up

      self.class.depends.each do |dep|
        dep.new.up
      end

      if satisfied?
        puts "SATISFIED: #{self.class.name}".colorize(:light_white)
      else
        puts "IMPORTING: #{self.class.name}".colorize(:green)
        _up
      end

    end

    # Reverse the import.
    def down

      if satisfied?
        puts "REVERTING: #{self.class.name}".colorize(:green)
        _down
      else
        puts "SATISFIED: #{self.class.name}".colorize(:light_white)
      end

    end

    # Has the import been run?
    def satisfied?
      raise NotImplementedError
    end

  end
end
