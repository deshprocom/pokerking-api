module V1
  class InfosController < ApplicationController
    def show
      @info = Info.find(params[:id])
    end

    def index
      @infos = Info.show_in_homepage
                   .published
                   .yield_self{ |it| params[:status].eql?('hot') ? it.hot : it }
                   .page_order
                   .page(params[:page]).per(20)
    end

    # 资讯搜索 分关键词搜索，时间搜索，以及类别搜索
    def search
      @infos = Info.show_in_homepage.published

      # 关键词查询
      if (params[:keyword])
        KeywordRedis.store_keyword('info', params[:keyword])
        @infos = @infos.where('title like ?', "%#{params[:keyword]}%").page_order.page(params[:page]).per(20)
        return render :index
      end

      # 日期查询
      if (params[:date])
        @infos =  @infos.where('created_at >= ? and created_at < ?', params[:date], (params[:date].to_i + 1).to_s).page_order.page(params[:page]).per(20)
        return render :index
      end

      # 标签查询
      if (params[:tag])
        @info_tag = InfoTag.where('name = ? or name_en = ?', params[:tag], params[:tag]).first
        if @info_tag.present?
          @infos = @info_tag.infos.page_order.page(params[:page]).per(20)
        else
          @infos = @info_tag
        end
        return render :index
      end

      raise_error 'params_missing'
    end

    def history_search
      # 去缓存读取所有搜索过的历史关键词
      history = KeywordRedis.read_keyword 'info'
      # 每次取多少个词 由前端传递过来 默认取8个
      number = params[:number].to_i <= 0 ? 8 : params[:number].to_i
      @history_array = history.blank? ? [] : history.split('|')[0...number].uniq
    end

    def remove_history_search
      KeywordRedis.remove_keyword('info')
      render_api_success
    end
  end
end
