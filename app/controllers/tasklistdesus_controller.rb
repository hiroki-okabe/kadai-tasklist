class TasklistdesusController < ApplicationController
  before_action :require_user_logged_in
  before_action :current_user, only: [:destroy]
  
  def create
    @tasklistdesu = current_user.tasklistdesus.build(tasklistdesu_params)
    if @tasklistdesu.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasklistdesus = current_user.tasklistdesus.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @tasklistdesu.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

    def tasklistdesu_params
      params.require(:tasklistdesu).permit(:content)
    end
    
    def correct_user
      @tasklistdesu = current_user.tasklistdesus.find_by(id: params[:id])
      unless @tasklistdesu
        redirect_to root_url
      end
    end
end
