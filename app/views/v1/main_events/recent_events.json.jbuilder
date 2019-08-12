json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.recent_event do
    next if @recent_event.blank?
    json.id         @recent_event.id
    json.name        @recent_event.name
    json.logo        @recent_event.logo_url
    json.live_url    @recent_event.live_url
    json.begin_time  @recent_event.begin_time.to_i
    json.end_time    @recent_event.end_time.to_i
    json.description @recent_event.description
  end

  json.events do
    json.array! @events do |event|
      next if event.blank?
      json.id          event.id
      json.name        event.name
      json.logo        event.logo_url
      json.live_url    @recent_event.live_url
      json.begin_time  event.begin_time.to_i
      json.end_time    event.end_time.to_i
    end
  end
end

