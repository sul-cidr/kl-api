# Kindred Britain JSON API

A JSON API for Kindred Britain v2.

## Database migration

This app includes code to restructure and import data from the Kindred Britain v1 database. Here's how each of the fields in the old database is treated by the migration:

- **`indiv`**

  - `recno`: **TODO**
  - `indiv_id`: Migrated directly into `Person` / `legacy_id`.
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
  - `birthyear`: Migrated directly into `Person` / `birth_year`.
  - `deathyear`: Migrated directly into `Person` / `death_year`.
  - `birth_abt`: **TODO**
  - `death_abt`: **TODO**
  - `odnb`: Dropped (empty).
  - `sim20`: Dropped (empty).
  - `birt`: Dropped (empty).
  - `deat`: Dropped (empty).
  - `birthdate`: Dropped (empty).
  - `deathdate`: Dropped (empty).
  - `perioddist`: Dropped (empty).
  - `search_names`: Dropped - let's use Solr / Elasticsearch.
  - `perioddist_new`: Dropped (empty).
  - `best`: **TODO**
  - `dest`: **TODO**
  - `bestconf`: **TODO**
  - `destconf`: **TODO**
  - `chantext`: **TODO**
  - `diedyoung`: Dropped (empty).
  - `spfx`: **TODO**
