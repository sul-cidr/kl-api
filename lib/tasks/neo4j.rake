
namespace :neo4j do

  desc "Index genealogical relationships"
  task :index => :environment do
    Person.index
  end

end
