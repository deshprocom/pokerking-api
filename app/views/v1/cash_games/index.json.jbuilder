json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.items do
    json.array! @cash_games do |cash_game|
      json.id             cash_game.id
      json.name           cash_game.name.to_s
      json.image          cash_game.image_url
      json.position       cash_game.position.to_i
      json.created_at     cash_game.created_at.to_i
    end
  end
end
