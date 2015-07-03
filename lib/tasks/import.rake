

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
      task :birth_death_years => [:environment, :rows] do

        DB[:indiv].each do |i|
          birth_year = i[:birthyear] || i[:birthdate] || i[:best]
          death_year = i[:deathyear] || i[:deathdate] || i[:dest]
        end

      end

    end
  end
end
