json.partial! 'common/basic', api_result: ApiResult.success_result

json.data do
  json.id                @queue_member.id
  json.nickname          @queue_member.nickname
  json.index             @queue_member.get_index
  json.created_at        @queue_member.created_at.to_i
end

