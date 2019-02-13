json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.recent_event do
    json.id         @recent_event.id
    json.name        @recent_event.name
    json.logo        @recent_event.logo_url
    json.begin_time  @recent_event.begin_time.to_i
    json.end_time    @recent_event.end_time.to_i
    json.description @recent_event.description
  end

  json.events do
    json.array! @events do |event|
      json.id          event.id
      json.name        event.name
      json.logo        event.logo_url
      json.begin_time  event.begin_time.to_i
      json.end_time    event.end_time.to_i
    end
  end
end

