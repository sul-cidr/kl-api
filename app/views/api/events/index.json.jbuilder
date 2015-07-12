
json.array! @events do |event|
  json.extract!(
    event,
    :id,
    :name,
    :description,
    :year,
    :date,
    :lonlat,
  )
end
