json.array!(@scans) do |scan|
  json.extract! scan, :id, :gem_list
  json.url scan_url(scan, format: :json)
end
