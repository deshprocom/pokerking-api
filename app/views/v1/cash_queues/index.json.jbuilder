json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.items do
    json.array! @cash_queues do |cash_queue|
      json.cash_game_id               cash_queue.cash_game_id
      json.small_blind                cash_queue.small_blind
      json.big_blind                  cash_queue.big_blind
      json.table_numbers              cash_queue.table_numbers
      json.cash_queue_members_count   cash_queue.cash_queue_members_count
      json.created_at                 cash_queue.created_at.to_i
    end
  end
end
