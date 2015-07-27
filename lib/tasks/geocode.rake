
namespace :geocode do

  desc "Geocode events"
  task :events => :environment do

    events = Event.where { address != nil }
    bar = ProgressBar.new(events.count)

    events.each do |event|
      event.geocode
      event.save
      bar.increment!
    end

  end

end
