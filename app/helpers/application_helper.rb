module ApplicationHelper

  def error_messages_for(resource)
    render "shared/error_messages", :resource => resource
  end

end
