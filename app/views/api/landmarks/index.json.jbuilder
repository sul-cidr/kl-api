
json.array! @landmarks do |landmark|
  json.extract!(
    landmark,
    :id,
    :name,
    :lonlat,
  )
end
