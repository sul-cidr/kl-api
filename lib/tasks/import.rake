
namespace :db do

  desc "Import data from v1"
  task :import => :environment do

    # Connect to legacy database.
    legacy = Rails.configuration.database_configuration["legacy"]
    DB = Sequel.connect(:adapter => "postgres", **legacy.symbolize_keys)

    DB[:indiv].each{|i|
      Person.create(
        given_name:   i[:givn],
        family_name:  i[:surn],
        sex:          i[:sex],
      )
    }

  end

end
