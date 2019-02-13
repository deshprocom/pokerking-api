json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.info do
    json.id             @info.id
    json.image          @info.image_url
    json.title          @info.title
    json.description    @info.description
    json.created_at     @info.created_at.to_i
  end
end

