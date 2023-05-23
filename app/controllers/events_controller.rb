class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  impressionist :actions => %i[show index]

  # GET /updates or /updates.json
  def index
    @popular_news = Event.order(impressions_count: :desc).limit(2)

    @all_events = Event.all
    yesterday = Date.yesterday
    @events = Event.where.not(id: @popular_news.pluck(:id))
    @user_edition = Edition.where(user_id: current_user.id)
    @popular_news_yesterday = Event.where("DATE(created_at) = ?", yesterday).order(impressions_count: :desc).limit(4)
  end

  def like
    @event = Event.find(params[:id])
    current_user = User.find(params[:user_id])

    @event.like(current_user)

    render json: { success: true, likes_count: @event.likes_count }
  end

  # GET /events/1 or /events/1.json
  def show

    @user = User.find(@event.user_id)
    impressionist(@event)
  end

  def category
    @categorys = params[:category].gsub('_', ' ')
    @events = Event.where(category: @categorys)
  end

  def city
    @events = Event.where(city: params[:name])
  end

  def find
    search = params[:search].gsub('_', ' ')
    if search == "all"
      @events = Event.all
    else
      @events = Event.where("title LIKE ?", "%#{params[:search]}%")
    end
  end

  # GET /events/new
  def new
    @editions_list = Edition.where(user_id: current_user.id, verified: true)
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    @event.tag_list = params[:event][:tag_list] # Получаем теги из параметров формы

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_comment
    @event = Event.find(params[:id])
    @comment = @event.event_comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @event, notice: 'Comment created successfully.'
    else
      redirect_to @event, alert: 'Failed to create comment.'
    end
  end

  private
    def comment_params
      params.require(:event_comment).permit(:content)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :body, :category, :tag_list, :header, :city, :edition_id)
    end
end
