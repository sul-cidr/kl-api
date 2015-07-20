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

## API specification

The API provides information about four basic entity types - events, landmarks, people, and photographs.

### `/events`

#### Parameters

  - `start_year` (integer) - Just get events that occurred on or after the provided year.
  - `end_year` (integer) - Just get events that occurred on or before the provided year.
  - `extent` (WKT) - Match events that fall inside of an arbitrary polygon.
  - `lon` (float), `lat` (float), `radius` (float) - Match events that fall within a given distance of a center point.
  - `people` (integer[array]) - Match events that associated with a set of people, identified by ID.
  - `occupation` (integer) - Match events that associated with a set of people of a given occupation., identified by ID.
  - `type` (integer) - Match events of a given type, identified by ID.
  - `source` (integer), `steps` (integer) - Match events associated with people that are with N genealogical "steps" of a given person (the "source"), identified by ID.
