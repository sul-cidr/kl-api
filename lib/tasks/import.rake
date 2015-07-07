
require_all "./lib/import"

namespace :db do
  namespace :import do

    desc "Import data from KB1"
    task :up => :environment do
      Import::PersonRows.new.up
      Import::PersonBirthDeath.new.up
      Import::OccupationRows.new.up
      Import::OccupationLinks.new.up
      Import::EventRows.new.up
      Import::EventTypeRows.new.up
    end

    desc "Roll back the import"
    task :down => :environment do
      Import::PersonRows.new.down
      Import::OccupationRows.new.down
      Import::EventRows.new.down
    end

  end
end
