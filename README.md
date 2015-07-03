# Kindred Britain JSON API

A JSON API for Kindred Britain v2.

## Database migration

This app includes code to restructure and import data from the Kindred Britain v1 database. Here's how each of the fields in the old database is treated by the migration:

- **`indiv`**

  - `givn`: Migrated directly into `Person` / `given_name`.
  - `surn`: Migrated directly into `Person` / `family_name`.
