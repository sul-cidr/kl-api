# API specification

## Requirements

- Load events associated with an individual person.
- Load events associated with all people in a given occupation.
- Load events by type - births, marriages, deaths, etc.
- Load places by type - schools, churches, etc.
- Given two people, get the genealogical shortest path between them.
- Full-text search on people, occupations, and landmarks (names).
- Load events associated with people within N genealogical steps of a person.
- Load events with a range of dates.
- Load events within N radius of a point.
- Load events inside an arbitrary polygon.
- Load photographs within N radius of a point.
- Load photographs inside an arbitrary polygon.

## Endpoints

- /events
  - `person`
  - `occupation`
  - `type`
  - `steps`
  - `start_date`
  - `end_date`
  - `extent`
  - `point`
  - `radius`

- /landmarks
  - `type`

- /relation
  - `source`
  - `target`

- /search
  - `query`

- /photographs
  - `extent`
  - `point`
  - `radius`
