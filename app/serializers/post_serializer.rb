class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :user_id
end
