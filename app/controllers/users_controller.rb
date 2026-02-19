class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # On utilise le city_id envoyé par le formulaire
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      city_id: params[:city_id] # Liaison directe avec l'ID de la ville
    )

    if @user.save
      log_in(@user)
      flash[:success] = "Compte créé avec succès !"
      redirect_to root_path
    else
      render :new
    end
  end
end