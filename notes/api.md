# API specification

## Requirements

- Load events associated with an individual person. (DONE)
- Load events associated with all people in a given occupation. (DONE)
- Load events by type - births, marriages, deaths, etc. (DONE)
- Load events associated with people within N genealogical steps of a person.
- Load events with a range of dates. (DONE)
- Load events within N radius of a point. (DONE)
- Load events inside an arbitrary polygon. (DONE)
- Load places by type - schools, churches, etc. (DONE)
- Given two people, get the genealogical shortest path between them.
- Full-text search on people, occupations, and landmarks.
- Load photographs within N radius of a point. (DONE)
- Load photographs inside an arbitrary polygon. (DONE)

## Endpoints

- /events
  - `person` DONE
  - `occupation` DONE
  - `type` DONE
  - `steps`
  - `start_year` DONE
  - `end_year` DONE
  - `extent` DONE
  - `lon` DONE
  - `lat` DONE
  - `radius` DONE

- /landmarks
  - `type` DONE
  - `extent` DONE
  - `lon` DONE
  - `lat` DONE
  - `radius` DONE

- /relation
  - `source`
  - `target`

- /search
  - `query`

- /photographs
  - `extent` DONE
  - `lon` DONE
  - `lat` DONE
  - `radius` DONE
