
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
  Import::RoleRows
])

namespace :db do
  namespace :import do

    desc "Import data from KB1"
    task :up => :environment do
      runner.up
    end

    namespace :down do
      runner.steps.each do |name, step|
        desc "Roll back #{name}"
        task name => :environment do
          runner.down(name)
        end
      end
    end

  end
end
