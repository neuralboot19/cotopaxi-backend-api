class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :picture, :facebook_access_token, :email
  belongs_to :candidate
end
