
namespace :neo4j do

  desc "Index genealogical relationships"
  task :index => :environment do
    Graph::Person.index!
  end

end
