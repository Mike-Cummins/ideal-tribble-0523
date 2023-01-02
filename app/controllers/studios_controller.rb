class StudiosController < ApplicationController

  def index
    @studios = Studio.all
  end
  
  def show
    @studio = Studio.find(params[:id])
    @all_actors = @studio.all_actors
  end
end