module CapybaraSelectors

  Capybara.add_selector(:task_field) do
    xpath { |num| XPath.css("div#tasks > div.task_field:nth-child(#{num}) input") }
  end

end