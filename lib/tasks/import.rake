

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

        DB[:indiv].each do |i|
          Person.create(
            legacy_id:    i[:indiv_id],
            given_name:   i[:givn],
            family_name:  i[:surn],
            sex:          i[:sex],
          )
        end

      end

      desc "Migrate birth / death years"
      task :birth_death => :environment do

        DB[:indiv].each do |i|

          birth_year = i[:birthyear] || i[:birthdate] || i[:best]
          death_year = i[:deathyear] || i[:deathdate] || i[:dest]

          Person.find_by(legacy_id: i[:indiv_id]).update(
            birth_year: birth_year,
            death_year: death_year
          )

        end

      end

    end
  end
end
