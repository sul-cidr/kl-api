

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
