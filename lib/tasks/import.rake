
require_all "./lib/import"

runner = Import::Runner.from_steps([
  Import::CreateEvents,
  Import::CreateEventTypes,
  Import::CreateEventRoles,
  Import::CreatePeople,
  Import::CreateLandmarks,
  Import::CreateOccupations,
  Import::CreatePhotographs,
  Import::LinkPeopleWithOccupations,
  Import::LinkPeopleWithEvents,
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
