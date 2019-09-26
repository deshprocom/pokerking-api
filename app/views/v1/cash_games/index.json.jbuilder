json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.items do
    json.array! @cash_games do |cash_game|
      json.id             cash_game.id
      json.name           cash_game.name.to_s
      json.table_type     cash_game.table_type.to_s
      json.image          cash_game.image_url
      json.image_en       cash_game.image_en_url.blank? ? cash_game.image_url : cash_game.image_en_url
      json.image_complex  cash_game.image_complex_url.blank? ? cash_game.image_url : cash_game.image_complex_url
      json.position       cash_game.position.to_i
      json.amap_poiid     cash_game.amap_poiid
      json.amap_location  cash_game.amap_location
      json.notice         cash_game.notice
      json.created_at     cash_game.created_at.to_i
    end
  end
end
