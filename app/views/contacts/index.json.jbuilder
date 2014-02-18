json.array!(@contacts) do |contact|
  json.extract! contact, :id, :title, :first_name, :last_name, :company, :phone, :email, :address, :post_code, :text
  json.url contact_url(contact, format: :json)
end
