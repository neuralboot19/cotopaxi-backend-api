module SerializableResource
  def get_resource(object)
    ActiveModelSerializers::SerializableResource.new(object).as_json  
  end
end