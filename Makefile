
start:

  rake neo4j:config[test,7474]
  rake neo4j:config[development,7474]

  rake neo4j:start[test]
  rake neo4j:start[development]

stop:

  rake neo4j:stop[test]
  rake neo4j:stop[development]
