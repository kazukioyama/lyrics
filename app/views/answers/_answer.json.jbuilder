json.extract! answer, :id, :user_id, :post_id, :body, :created_at, :updated_at
json.url answer_url(answer, format: :json)
