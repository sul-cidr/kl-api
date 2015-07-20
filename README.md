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

### `/api/events`

#### Parameters

  - **`start_year`** (integer) - Match events that occurred on or after the provided year.
    - `/api/events?start_year=1564`

  - **`end_year`** (integer) - Match events that occurred on or before the provided year.
    - `/api/events?end_year=1616`

  - **`extent`** (WKT) - Match events that fall inside of an arbitrary polygon.
    - `/api/events?extent=POLYGON((0 0, 0 1,1 1,1 0,0 0))`

  - **`lon`** (float) + **`lat`** (float) + **`radius`** (float) - Match events within a radius of a center point.
    - `/api/events?lon=74.05&lat=40.7&radius=3`

  - **`people`** (integer) - Match events associated with one or more people, identified by ID.
    - `/api/events?people=1`
    - `/api/events?people[]=1&people[]=2`

  - **`occupations`** (integer) - Match events associated with people of one or more occupations, identified by ID.
    - `/api/events?occupations=1`
    - `/api/events?occupations[]=1&occupations[]=2`

  - **`types`** (integer) - Match events of one or more types, identified by ID.
    - `/api/events?type=1`
    - `/api/events?type[]=1&type[]=2`

  - **`source`** (integer) + **`steps`** (integer) - Match events associated with people that are with N genealogical "steps" of a given person (the "source"), identified by ID.
    - `/api/events?source=1&steps=3`

### `/api/landmarks`

#### Parameters

  - **`extent`** (WKT) - Match landmarks that fall inside of an arbitrary polygon.

  - **`lon`** (float) + **`lat`** (float) + **`radius`** (float) - Match landmarks within a radius of a center point.

  - **`types`** (integer) - Match landmarks of one or more types, identified by ID.

### `/api/photographs`

#### Parameters

  - **`extent`** (WKT) - Match photographs that fall inside of an arbitrary polygon.

  - **`lon`** (float) + **`lat`** (float) + **`radius`** (float) - Match photographs within a radius of a center point.

### `/api/relation`

#### Parameters

  - **`source`** (integer) + **`target`** (integer) - Return a shortest path between two people, identified by ID.

### `/api/search`

#### Parameters

  - **`query`** (string) - Search the names of people, landmarks, and occupations.
