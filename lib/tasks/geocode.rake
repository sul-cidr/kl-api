
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

  desc "Geocode photographs"
  task :photographs => :environment do

    bar = ProgressBar.new(Photograph.count)

    Photograph.all.each do |photo|
      photo.geocode
      photo.save
      bar.increment!
    end

  end

end
