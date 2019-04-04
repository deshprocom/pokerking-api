json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  # 普通的列
  json.ordinary_queues do
    json.array! @ordinary_queues do |cash_queue|
      json.partial! 'v1/cash_queues/item', cash_queue: cash_queue
    end
  end

  # 有限制的列
  json.high_limit_queues do
    if @high_limit_queue.blank?
      json.status false
    else
      json.status true
      json.partial! 'v1/cash_queues/item', cash_queue: @high_limit_queue
    end
  end

  # 桌号的问题
  json.tables do
    json.array! @sorted_queues do |cash_queue|
      json.table_no     cash_queue[0]
      json.cash_game_id cash_queue[1].cash_game_id
      json.small_blind  cash_queue[1].small_blind
      json.big_blind    cash_queue[1].big_blind
    end
  end
end
