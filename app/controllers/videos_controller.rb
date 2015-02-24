class VideosController < ApplicationController
 
  def index
    @videos = Video.order('created_at DESC').paginate(page: params[:page], per_page: 15)
  end

  def new
    @video = Video.new
  end
   
  def create
    @video = Video.new(params.require(:video).permit(:link))
    if @video.save
      flash[:success] = 'Video added!'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def search
    if params[:search].present?
      @videos = Video.search(params[:search])
    else
      @videos = Video.order('created_at DESC').paginate(page: params[:page], per_page: 15)
    end
  end
end