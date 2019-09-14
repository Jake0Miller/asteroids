class FriendsSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :neo_reference_id, :user_id, :asteroid
end
