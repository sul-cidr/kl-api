
namespace :csv do

  desc "Make a photographs CSV for Fusion Tables"
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

end
