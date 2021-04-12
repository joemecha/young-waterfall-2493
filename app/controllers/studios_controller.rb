class StudiosController < ApplicationController
  def index
  end

  def show
    @studio = Studio.find(params[:id])
  end
end
