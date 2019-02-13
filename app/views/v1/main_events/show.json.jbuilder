json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.event do
    json.id          @event.id
    json.name        @event.name
    json.logo        @event.logo_url
    json.begin_time  @event.begin_time.to_i
    json.end_time    @event.end_time.to_i
    json.description @event.description
  end
end

