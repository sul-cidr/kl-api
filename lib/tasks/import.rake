
require_all "./lib/import"

runner = Import::Runner.from_steps([
  Import::PersonRows,
  Import::PersonBirthDeath,
  Import::OccupationRows,
  Import::OccupationLinks,
  Import::EventRows,
  Import::EventTypeRows,
  Import::EventTypeLinks,
  Import::PersonEventRows,
  Import::EventDates,
  Import::LandmarkRows,
  Import::RoleRows,
  Import::MonumentRows,
])

namespace :db do
  namespace :import do

    desc "Import data from KB1"
    task :up => :environment do
      runner.up
    end

    desc "Roll back an import step"
    task :down, [:step] => :environment do |t, args|
      runner.down(args.step)
    end

  end
end
