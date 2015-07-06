

class ImportStep

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
      puts "SATISFIED: #{self.class.name}".colorize(:green)
    else
      _up
    end

  end

  # Reverse the import.
  def down

    if satisfied?
      _down
    else
      puts "SATISFIED: #{self.class.name}".colorize(:green)
    end

  end

  # Has the import been run?
  def satisfied?
    return false
  end

end


class ImportPersonRows < ImportStep

  @depends = []

  def _up
    @DB[:indiv].each do |i|
      Person.create(
        legacy_id:    i[:indiv_id],
        given_name:   i[:givn],
        family_name:  i[:surn],
        sex:          i[:sex],
      )
    end
  end

  def _down
    Person.delete_all
  end

  def satisfied?
    Person.count > 0
  end

end


# Get the legacy parameters.
legacy = Rails.configuration.database_configuration["legacy"]

# Initialize the connection.
DB = Sequel.connect(
  :adapter => "postgres",
  **legacy.symbolize_keys
)


namespace :db do
  namespace :import do
    namespace :person do

      desc "Import rows"
      task :rows => :environment do
        ImportPersonRows.new.down
      end

      desc "Migrate birth / death years"
      task :birth_death => :environment do

        DB[:indiv].each do |i|

          # TODO: Do we need to preserve the fact that the *abt and *est fields
          # are approximate?

          birth_year = i[:birthyear] || i[:birth_abt] || i[:best]
          death_year = i[:deathyear] || i[:death_abt] || i[:dest]

          Person.find_by(legacy_id: i[:indiv_id]).update(
            birth_year: birth_year,
            death_year: death_year
          )

        end

      end

    end
  end
end
