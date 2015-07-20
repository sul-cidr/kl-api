
namespace :lonlat do

  desc "Stub event coordinates"
  task :event => :environment do
    Event.stub_lonlats
  end

  desc "Stub photograph coordinates"
  task :photo => :environment do
    Photograph.stub_lonlats
  end

end
