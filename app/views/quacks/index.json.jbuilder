json.array!(@quacks) do |quack|
  json.extract! quack, :id, :name, :title
  json.url quack_url(quack, format: :json)
end
