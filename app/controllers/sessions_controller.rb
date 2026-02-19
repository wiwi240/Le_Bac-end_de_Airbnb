class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:success] = "Connexion réussie."
      redirect_to root_path
    else
      flash.now[:danger] = 'Email ou mot de passe invalide.'
      render :new
    end
  end

  def destroy
    log_out
    flash[:notice] = "Déconnexion effectuée."
    redirect_to root_path
  end
end