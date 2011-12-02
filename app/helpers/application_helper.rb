module ApplicationHelper

  def error_messages_for(resource)
    render "shared/error_messages", :resource => resource
  end

  def flash_messages
    flash.collect do |key, message|
      content_tag :div, message, :id => "flash_#{key}", :class => "flash_message"
    end.join.html_safe
  end

  def title_tag
    title = content_for(:title) if content_for?(:title)
    content_tag :title, [title, AppConfig.name].compact.join(" &laquo; ").html_safe
  end

  def title(t, opts={})
    content_for(:title) { t }
  end

end
