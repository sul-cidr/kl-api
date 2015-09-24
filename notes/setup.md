# Environment setup

1. If you don't already have it, install Postgres locally.

  ```
  brew update
  brew install postgres
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  ```

1. Install rbenv (Ruby version manager) and Ruby 2.2.2:

  ```
  brew install rbenv ruby-build
  rbenv install 2.2.2
  ```

1. Install Java 7.

  ```
  brew install caskroom/cask/brew-cask
  brew cask install java7
  ```

1. Create a local database called `kb_legacy` for the Kindred Britain data.

  ```
  createdb kb_legacy
  ```

1. Grab the KB1 database dump and source it locally. This will flash some warnings about roles not existing, but these don't matter.

  ```
  pg_restore -d kb_legacy kb1.sql
  ```

1. Fork and clone the [kb-api](https://github.com/sul-cidr/kb-api) repo.

1. Change down into the repo and install dependencies with `bundle`.

1. Install test / development instances of Neo4j.

  ```
  rake neo4j:install[community-2.2.3,test]
  rake neo4j:config[test,7474]
  rake neo4j:start[test]

  rake neo4j:install[community-2.2.3,development]
  rake neo4j:config[test,7475]
  rake neo4j:start[test]
  ```

1. Install a development Solr server.

  ```
  rake sunspot:solr:start
  ```

1. Run the test suite with `rake`. If this passes, everything is configured correctly.
