json.extract! question, :id, :title, :body, :created_at, :updated_at
json.url quiz_url(question, format: :json)
