class CabinSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :maxCapacity, :regularPrice, :discount, :description, :imageUrl
end
