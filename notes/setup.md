# Environment setup

1. Create a local database called `kb_legacy` for the Kindred Britain data.

  ```
  createdb kb_legacy
  ```

1. Grab the KB1 database dump and source it locally. This will flash some warnings about roles not existing, but these don't matter.

  ```
  pg_restore -d kb_legacy kb1.sql
  ```

1. Fork and clone the [kb-api](https://github.com/sul-cidr/kb-api) repo.
