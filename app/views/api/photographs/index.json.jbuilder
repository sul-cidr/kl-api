
json.array! @photographs do |photograph|
  json.extract!(
    photograph,
    :id,
    :flickr_id,
    :lonlat,
    :url,
  )
end
