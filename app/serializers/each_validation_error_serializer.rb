class EachValidationErrorSerializer
  def initialize(record, error_field, details, message)
    @record, @error_field, @details, @message = record, error_field, details, message
  end

  def generate
    { resource: resource, field: field, code: code, message: @message }
  end

  private 
  def resource
    I18n.t(underscored_resource_name, scope: [:api_validation, :resources])
  end

  def field
    I18n.t(@error_field, scope: [:api_validation, :fields, underscored_resource_name])
  end

  def code
    I18n.t(@details, scope: [:api_validation, :code])
  end

  def underscored_resource_name
    @record.class.to_s.gsub("::", "").underscore
  end
end