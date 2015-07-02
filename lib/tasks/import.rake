

desc "Import data from v1."
task :import => :environment do

  # Connect to legacy database.
  config = Rails.configuration.database_configuration["legacy"]
  DB = Sequel.connect(:adapter => "postgres", **config.symbolize_keys)

  DB[:indiv].each{|i|
    Person.create(
      family_name:  i[:surn],
      given_name:   i[:givn],
    )
  }

end
