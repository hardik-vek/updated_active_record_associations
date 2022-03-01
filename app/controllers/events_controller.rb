class EventsController < ApplicationController
  # before_action :logged_in?
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event Suceesfully created"
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Event Successfully edited"
      redirect_to events_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def profile
    @user = current_user
    @events = Event.all
    @enroll_events = @user.enrollments.all
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :event_date, :user_id)
  end

  def require_same_user
    if current_user != @event.user
      flash[:notice] = "You can only edit or delete your own article"
      redirect_to root_path
    end
  end
end
