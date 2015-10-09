
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

    photos = Photograph.where { needs_coord == true }
    bar = ProgressBar.new(photos.count)

    photos.each do |photo|
      photo.geocode
      photo.save
      bar.increment!
    end

  end

end
