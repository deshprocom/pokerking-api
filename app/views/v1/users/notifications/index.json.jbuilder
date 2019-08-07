json.partial! 'common/basic', api_result: ApiResult.success_result
# data
json.data do
  json.notifications do
    json.array! @notifications do |notification|
      json.id            notification.id
      json.notify_type   notification.notify_type
      json.title         notification.title
      json.content       notification.content
      json.color_type    notification.color_type
      json.read          notification.read
      json.created_at    notification.created_at.to_i
    end
  end
end
