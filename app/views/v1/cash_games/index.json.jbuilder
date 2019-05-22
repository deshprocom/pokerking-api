json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.items do
    json.array! @cash_games do |cash_game|
      json.id             cash_game.id
      json.name           cash_game.name.to_s
      json.image          cash_game.image_url
      json.image_en       cash_game.image_en_url.blank? ? cash_game.image_url : cash_game.image_en_url
      json.image_complex  cash_game.image_complex_url.blank? ? cash_game.image_url : cash_game.image_complex_url
      json.position       cash_game.position.to_i
      json.notice         cash_game.notice
      json.blind_navigation cash_game.blind_navigation_url.to_s
      json.created_at     cash_game.created_at.to_i
    end
  end
end
