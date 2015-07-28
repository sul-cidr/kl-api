
namespace :csv do

  desc "Generate a photographs CSV"
  task :photos, [:path] => :environment do |t, args|

    path = args.path || "photos.csv"

    CSV.open(path, "w",
      :headers => ["url", "longitude", "latitude"],
      :write_headers => true,
    ) do |fh|

      Photograph.where { lonlat != nil }.each do |p|
        fh << [p.url, p.lonlat.x, p.lonlat.y]
      end

    end

  end

  desc "Generate an events CSV"
  task :events, [:path] => :environment do |t, args|

    path = args.path || "events.csv"

    CSV.open(path, "w",
      :headers => ["name", "address", "longitude", "latitude"],
      :write_headers => true,
    ) do |fh|

      Event.where { lonlat != nil }.each do |e|
        fh << [e.name, e.address, e.lonlat.x, e.lonlat.y]
      end

    end

  end

end
