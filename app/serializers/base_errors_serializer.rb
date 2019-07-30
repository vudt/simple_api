class BaseErrorsSerializer < ActiveModel::Serializer 
  attributes  :success, :errors

  def success
    false
  end
end