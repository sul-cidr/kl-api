
json.results do
  json.array! @results.hits do |hit|

    json.type hit.class_name
    json.result hit.result

    # Wrap the highlights in <em>'s.
    json.highlight hit.highlight(:name).format { |term|
      "<em>#{term}</em>"
    }

  end
end
