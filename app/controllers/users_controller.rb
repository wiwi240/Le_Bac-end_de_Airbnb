class UsersController < ApplicationController
  # On doit être connecté pour modifier
  before_action :authenticate_user, only: [:edit, :update]
  # On ne peut modifier que son propre profil
  before_action :is_owner?, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Bienvenue ! Ton compte a été créé."
      redirect_to root_path, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    # On récupère les params dans une variable modifiable
    post_params = user_params
    
    # SI le mot de passe est vide, on le supprime des params pour ne pas le modifier
    if post_params[:password].blank?
      post_params.delete(:password)
      post_params.delete(:password_confirmation)
    end

    if @user.update(post_params)
      flash[:success] = "Ton profil a été mis à jour avec succès !"
      redirect_to user_path(@user), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :email, :age, :city_id, :password, :password_confirmation)
  end

  def authenticate_user
    unless logged_in?
      flash[:danger] = "Connecte-toi d'abord."
      redirect_to new_session_path, status: :see_other
    end
  end

  def is_owner?
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:danger] = "Tu ne peux pas toucher à ce profil."
      redirect_to root_path, status: :see_other
    end
  end
end