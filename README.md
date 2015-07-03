# Kindred Britain JSON API

A JSON API for Kindred Britain v2.

## Database migration

This app includes code to restructure and import data from the Kindred Britain v1 database. Here's how each of the fields in the old database is treated by the migration:

- **`indiv`**

  - `recno`: **TODO**
  - `indiv_id`: **TODO**
  - `sex`: Migrated directly into `Person` / `sex`.
  - `fullname`: Dropped - this can be formed from the `given_name` and `family_name`.
  - `reli`: **TODO**
  - `givn`: Migrated directly into `Person` / `given_name`.
  - `surn`: Migrated directly into `Person` / `family_name`.
  - `marnm`: **TODO**
  - `npfx`: **TODO**
  - `nsfx`: **TODO**
  - `notes`: **TODO**
  - `fams`: **TODO**
  - `famc`: **TODO**
  - `birthyear`: **TODO**
  - `deathyear`: **TODO**
  - `birth_abt`: **TODO**
  - `death_abt`: **TODO**
  - `odnb`: **TODO**
  - `sim20`: **TODO**
  - `birt`: Dropped (all rows had empty values).
  - `deat`: Dropped (all rows had empty values).
  - `birthdate`: **TODO**
  - `deathdate`: **TODO**
  - `perioddist`: **TODO**
  - `search_names`: Dropped - let's use Solr / Elasticsearch.
  - `perioddist_new`: **TODO**
  - `best`: **TODO**
  - `dest`: **TODO**
  - `bestconf`: **TODO**
  - `destconf`: **TODO**
  - `chantext`: **TODO**
  - `diedyoung`: **TODO**
  - `spfx`: **TODO**
