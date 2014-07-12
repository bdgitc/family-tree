json.array!(@people) do |person|
  json.extract! person, :id, :first_name, :middle_name, :last_name, :parent_mother_id, :parent_father_id, :description, :dob, :pob
  json.url person_url(person, format: :json)
end
