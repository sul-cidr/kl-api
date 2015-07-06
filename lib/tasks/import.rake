
require "./lib/import"

namespace :db do
  namespace :import do

    desc "Import data from KB1"
    task :up => :environment do
      Import::PersonBirthDeath.new.up
    end

    desc "Roll back the import"
    task :down => :environment do
      Import::PersonBirthDeath.new.down
    end

  end
end
