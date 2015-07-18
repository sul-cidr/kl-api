
namespace :neo4j do

  desc "Index genealogical relationships"
  task :index => :environment do
    Graph::Person.index
  end

  desc "Clear all nodes"
  task :index => :environment do
    Graph::Person.delete_all
  end

end
