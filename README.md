# Kindred Britain JSON API

The Kindred London API is provides data about London-related people, events, landmarks, photographs and genealogical relationships in the Kindred Britain database.

## Project setup

To get up and running, first start a development Solr instance:

  - `rake sunspot:solr:start`

Second, install and configure Neo4j:

  - `rake neo4j:install[community-latest,development]`
  - `rake neo4j:install[community-latest,test]`
  - `rake neo4j:config[test,7475]`
  - `rake neo4j:start[development]`
  - `rake neo4j:start[test]`

And, now the test suite should run:

  - `rake`
