
namespace :neo4j do

  desc "Index genealogical relationships"
  task :index => :environment do
    Neo4j.new.index_kin!
  end

end
