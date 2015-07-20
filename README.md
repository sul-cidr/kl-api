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

#### Response

```json
[
    {
        "id": 7,
        "name": "Created 1st Baronet Hogg, of Upper Grosvenor Street",
        "description": null,
        "year": null,
        "date": "1846-07-20",
        "lonlat": "POINT (-0.24374332151346906 51.58753784221102)"
    },
    {
        "id": 37065,
        "name": "Baptised",
        "description": null,
        "year": null,
        "date": "1861-05-26",
        "lonlat": "POINT (0.1498699184529657 51.555930897697806)"
    },
    {
        "id": 8,
        "name": "University of California at Santa Cruz",
        "description": null,
        "year": 1969,
        "date": null,
        "lonlat": "POINT (-0.40351415209083 51.698286458689765)"
    },
    {
        "id": 9,
        "name": "Member of the Royal Society of Musicians",
        "description": null,
        "year": null,
        "date": "1797-06-01",
        "lonlat": "POINT (-0.07399497409301364 51.34817838985863)"
    },
    {
        "id": 12,
        "name": "Managed the Waddesdon Estate for James de Rothschild",
        "description": null,
        "year": 1922,
        "date": null,
        "lonlat": "POINT (0.16902884039846666 51.54600406960587)"
    },
    ...
]
```

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
