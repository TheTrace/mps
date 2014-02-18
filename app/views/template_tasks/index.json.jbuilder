json.array!(@template_tasks) do |template_task|
  json.extract! template_task, :id, :title, :text
  json.url template_task_url(template_task, format: :json)
end
