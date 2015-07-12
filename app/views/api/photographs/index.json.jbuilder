
json.array! @photographs do |photograph|
  json.extract!(
    photograph,
    :id,
    :slug,
    :lonlat,
  )
end
