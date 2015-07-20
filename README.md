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

The search endpoint runs a full-text search (via Solr) against people (first and last name), landmarks (name), and occupations (name). The results are returned as three separate lists of records, each under a top-level key that identified the result type. In the person results, the documents are boosted in Solr according to the number of events associated with the person, which pushes more "important" people towards the top.

#### Parameters

  - **`query`** (string) - Search the names of people, landmarks, and occupations.

#### Sample Responses

  - `/api/search?query=shakespeare`

    ```javascript
    {
        "people": [
            {
                "result": {
                    "id": 5493,
                    "family_name": "Shakespeare",
                    "given_name": "John",
                    "created_at": "2015-07-15T16:21:01.999Z",
                    "updated_at": "2015-07-15T16:23:26.305Z",
                    "sex": "M",
                    "birth_year": 1530,
                    "death_year": 1601,
                    "legacy_id": "I27327",
                    "birth_est": true,
                    "death_est": true
                },
                "highlight": "John <em>Shakespeare</em>"
            },
            {
                "result": {
                    "id": 27717,
                    "family_name": "Shakespeare",
                    "given_name": "William",
                    "created_at": "2015-07-15T16:22:05.717Z",
                    "updated_at": "2015-07-15T16:24:56.811Z",
                    "sex": "M",
                    "birth_year": 1564,
                    "death_year": 1616,
                    "legacy_id": "I27325",
                    "birth_est": true,
                    "death_est": true
                },
                "highlight": "William <em>Shakespeare</em>"
            },
            {
                "result": {
                    "id": 14158,
                    "family_name": "Barnes",
                    "given_name": "Hugh Shakespear",
                    "created_at": "2015-07-15T16:21:26.868Z",
                    "updated_at": "2015-07-15T16:24:01.330Z",
                    "sex": "M",
                    "birth_year": 1853,
                    "death_year": 1940,
                    "legacy_id": "I12125",
                    "birth_est": false,
                    "death_est": false
                },
                "highlight": "Hugh <em>Shakespear</em> Barnes"
            },
            // ...
        ],
        "landmarks": [],
        "occupations": []
    }
    ```
