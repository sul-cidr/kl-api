
require_all "./lib/import"

runner = Import::Runner.from_steps([
  Import::Person,
  Import::OccupationRows,
  Import::OccupationLinks,
  Import::Event,
  Import::EventTypeRows,
  Import::EventTypeLinks,
  Import::PersonEventRows,
  Import::LandmarkRows,
  Import::RoleRows
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
