json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.items do
    json.array! @cash_queue_members do |item|
      json.cash_queue_id              item.cash_queue_id
      json.nickname                   item.nickname
      json.small_blind                item.cash_queue.small_blind
      json.big_blind                  item.cash_queue.big_blind
      json.table_numbers              item.cash_queue.table_numbers
      json.created_at                 item.created_at.to_i
    end
  end
end
