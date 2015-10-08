
namespace :services do

  desc "Start Neo4j and Solr"
  task :start => :environment do

    `rake neo4j:config[test,7474]`

    #Rake::Task['neo4j:config'].execute('test', 7474)
    #Rake::Task['neo4j:config'].execute('development', 7475)

    #Rake::Task['neo4j:start'].execute('test')
    #Rake::Task['neo4j:start'].execute('development')

  end

  desc "Stop Neo4j and Solr"
  task :stop => :environment do
    Rake::Task['neo4j:stop'].execute('test')
    Rake::Task['neo4j:stop'].execute('development')
  end

end
