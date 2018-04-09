class CandidateSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :image
  attribute :votes do
    object.users.count
  end
end
