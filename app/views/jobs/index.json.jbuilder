json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :text
  json.url job_url(job, format: :json)
end
