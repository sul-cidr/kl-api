
json.array! @people do |person|
  json.extract!(
    person,
    :id,
    :family_name,
    :given_name,
    :sex,
    :birth_year,
    :death_year
  )
end
