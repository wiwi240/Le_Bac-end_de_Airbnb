class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :show]
  before_action :is_owner?, only: [:edit, :update, :destroy]

  def index
    # Sélection de tous les potins du plus récent au plus ancien
    @gossips = Gossip.all.order(created_at: :desc)
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content])
    @gossip.user = current_user
    if @gossip.save
      flash[:success] = "Potin créé."
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(title: params[:title], content: params[:content])
      flash[:success] = "Potin mis à jour."
      redirect_to @gossip
    else
      render :edit
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:notice] = "Potin supprimé."
    redirect_to root_path
  end

  private

  def authenticate_user
    unless logged_in?
      flash[:danger] = "Veuillez vous connecter."
      redirect_to new_session_path
    end
  end

  def is_owner?
    @gossip = Gossip.find(params[:id])
    unless current_user == @gossip.user
      flash[:danger] = "Accès refusé."
      redirect_to root_path
    end
  end
end