
json.array! @events do |event|
  json.extract!(
    event,
    :id,
    :name,
    :event_type_id,
    :description,
    :address,
    :year,
    :date,
    :lonlat,
  )
end
