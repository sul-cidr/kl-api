
json.people @ids do |id|
  json.merge! Person.find(id)
end

json.relationships do
  json.array! @rels
end
