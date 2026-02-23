class GossipsController < ApplicationController
  # On n'oblige pas à être connecté pour VOIR (show/index), seulement pour créer/modifier
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_owner?, only: [:edit, :update, :destroy]

  def index
    @gossips = Gossip.all.order(created_at: :desc)
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user

    if @gossip.save
      flash[:success] = "Ton potin a été publié avec succès !"
      # Redirige vers l'index des potins (sans bannière) plutôt que l'accueil
      redirect_to gossips_path 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      flash[:success] = "Potin mis à jour !"
      redirect_to @gossip
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:notice] = "Potin supprimé définitivement."
    # Redirige vers l'index pour rester sur la liste propre
    redirect_to gossips_path
  end

  private

  # Utilise les Strong Parameters pour la sécurité
  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  def authenticate_user
    unless logged_in?
      flash[:danger] = "Connecte-toi pour partager un secret !"
      redirect_to new_session_path
    end
  end

  def is_owner?
    @gossip = Gossip.find(params[:id])
    unless current_user == @gossip.user
      flash[:danger] = "Ce n'est pas ton secret, tu ne peux pas le modifier."
      redirect_to root_path
    end
  end
end