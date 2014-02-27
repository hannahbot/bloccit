class TopicsController < ApplicationController
  def index
    @topic = Topic.all
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic, message: "You need to be an admin to do that."
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to be an admin to do that."
  end

  def create
    @topic = Topic.new(topic_params)
    authorize! :create, @topic, message: "You need to be an admin to do that."
    if @topic.save
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error creating the topic. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.new(topic_params)
    authorize! :update, @topic, message: "You need to own the topic to do that."
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error updating the topic. Please try again."
      render :new
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :description)

  end
end