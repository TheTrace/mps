json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :text
  json.url task_url(task, format: :json)
end
