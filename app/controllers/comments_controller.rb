class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(content: params[:content], user: current_user, gossip: @gossip)
    if @comment.save
      flash[:success] = "Commentaire ajouté."
      redirect_to gossip_path(@gossip)
    else
      flash[:danger] = "Erreur lors de l'ajout du commentaire."
      redirect_to gossip_path(@gossip)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
      flash[:notice] = "Commentaire supprimé."
    end
    redirect_to gossip_path(params[:gossip_id])
  end

  private

  def authenticate_user
    unless logged_in?
      flash[:danger] = "Connectez-vous pour commenter."
      redirect_to new_session_path
    end
  end
end