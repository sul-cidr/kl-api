

namespace :db do

  desc "Import data from v1"
  task :import => :environment do

    # Connect to legacy database.
    legacy = Rails.configuration.database_configuration["legacy"]
    DB = Sequel.connect(:adapter => "postgres", **legacy.symbolize_keys)

    DB[:indiv].each{|i|
      Person.create(
        family_name:  i[:surn],
        given_name:   i[:givn],
      )
    }

  end

end
