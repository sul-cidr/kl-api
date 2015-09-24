
# Kindred Britain JSON API

[![](https://api.travis-ci.org/sul-cidr/kb-api.svg)](https://travis-ci.org/sul-cidr/kb-api)

The Kindred London API provides data about London-related people, events, landmarks, photographs and genealogical relationships in the Kindred Britain database.

## Specification

The API provides information about four basic entity types - events, landmarks, people, and photographs.

### `/api/events`

The events endpoint filters events by date, location, person, occupation, or type.

#### Parameters

  - **`start_year`** (integer) - Match events that occurred during or after the provided year.
    - `/api/events?start_year=1564`

  - **`end_year`** (integer) - Match events that occurred during or before the provided year.
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

The landmarks endpoint provides lists of landmarks, filtered by location or type.

#### Parameters

  - **`extent`** (WKT) - Match landmarks that fall inside of an arbitrary polygon.

  - **`lon`** (float) + **`lat`** (float) + **`radius`** (float) - Match landmarks within a radius of a center point.

  - **`types`** (integer) - Match landmarks of one or more types, identified by ID.

### `/api/photographs`

The photographs endpoint provides lists of photographs, filtered by location.

#### Parameters

  - **`extent`** (WKT) - Match photographs that fall inside of an arbitrary polygon.

  - **`lon`** (float) + **`lat`** (float) + **`radius`** (float) - Match photographs within a radius of a center point.

### `/api/relation`

The relation endpoint finds the genealogical shortest path that connects two people. The response includes the path itself - the sequence of people from person A to B - as well as an array of "relationships," one for each consecutive pair of people (`spouse`, `parent`, or `child`).

#### Parameters

  - **`source`** (integer) + **`target`** (integer) - Return a shortest path between two people.

### `/api/search`

The search endpoint runs a full-text search (via Solr) against people landmarks, and occupations. The results are returned as three separate lists of records, each under a top-level key that identifies the result type. Each individual hit has a `result` key, which contains the record itself, and a `highlight` key with the hit highlight from Solr.

In the person results, the documents are boosted in Solr according to the number of events associated with the person, which pushes more "important" people towards the top.

#### Parameters

  - **`query`** (string) - Search the names of people, landmarks, and occupations.
