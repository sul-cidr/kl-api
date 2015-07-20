
@results.each do |name, results|
  json.set! name, results.hits do |hit|

    json.result hit.result

    # Wrap the highlights in <em>'s.
    json.highlight hit.highlight(:name).format { |term|
      "<em>#{term}</em>"
    }

  end
end
