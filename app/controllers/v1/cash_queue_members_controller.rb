module V1
  class CashQueueMembersController < ApplicationController
    before_action :set_cash_queue

    def index
      @cash_queue_members = @cash_queue.cash_queue_members.order(created_at: :desc).page(params[:page]).per(10)
    end

    private

    def set_cash_queue
      @cash_queue = CashQueue.find(params[:cash_queue_id])
    end
  end
end
