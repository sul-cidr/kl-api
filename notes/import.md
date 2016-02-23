
# Data Import

1. Clone the [kl-data](https://github.com/sul-cidr/kl-data) repository.

1. Symlink kl-data as `./data` in the root directory of the kl-api app.

1. Create a Postgres database called `kl_legacy` and source in the `./data/kb.sql` dump.

1. Load the Rails database with `rake db:import:up`.

1. Index Neo4j with `rake neo4j:index`.

1. Harvest photos with `rake photos:harvest`;

1. TODO: Geocode events.
