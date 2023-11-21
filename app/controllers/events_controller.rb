class EventsController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    event = group.events.build(event_params)
    if event.save
      redirect_to group, notice: 'イベントを作成しました'
    else
      redirect_to group, alert: 'イベントの作成に失敗しました'
    end
  end
  
  def index
    @group = Group.find(params[:group_id])
    @events = @group.events
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :location, :details)
  end
end
