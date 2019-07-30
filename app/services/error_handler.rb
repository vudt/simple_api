class ErrorHandler 
  def initialize(e, status)
    @status = status
    @exception = e
  end

  def generate 
    { resource: resource, field: field, message: message }
  end

  private 
  def resource
    @status == 404 ? @exception.model.underscore : @exception.record.class.to_s.gsub("::", "").underscore
  end

  def field
    @exception.record.errors.first[0] if @status != 404
  end
  
  def message
    @status == 404 ? @exception.message : @exception.record.errors.first[1]
  end 
end