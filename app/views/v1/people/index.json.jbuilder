
json.array! @people do |person|
  json.extract!(person, :family_name, :given_name)
end
