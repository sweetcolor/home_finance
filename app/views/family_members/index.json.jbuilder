json.array!(@family_members) do |family_member|
  json.extract! family_member, :id, :name, :surname, :middle_name, :birthday
  json.url family_member_url(family_member, format: :json)
end
