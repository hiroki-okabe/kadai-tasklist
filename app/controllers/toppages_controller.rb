class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tasklistdesu = current_user.tasklistdesus.build
      @tasklistdesus = current_user.tasklistdesus.order('created_at DESC').page(params[:page])
    end
  end
end
