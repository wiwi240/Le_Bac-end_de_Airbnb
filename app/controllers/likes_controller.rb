class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @like = Like.new(user: current_user, gossip: @gossip)
    if @like.save
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def authenticate_user
    unless logged_in?
      flash[:danger] = "Connectez-vous pour liker."
      redirect_to new_session_path
    end
  end
end