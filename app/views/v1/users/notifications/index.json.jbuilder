json.partial! 'common/basic', api_result: ApiResult.success_result
# data
json.data do
  json.applies do
    json.array! @apply_notifications do |notification|
      json.partial! 'v1/users/notifications/base', notification: notification
    end
  end
  json.apply_unread_counts @apply_notification_unread

  json.events do
    json.array! @event_notifications do |notification|
      json.partial! 'v1/users/notifications/base', notification: notification
    end
  end
  json.event_unread_counts @event_notification_unread
end
