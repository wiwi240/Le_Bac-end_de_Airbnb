class StaticPagesController < ApplicationController
  def home
    # Sélection des 5 potins les plus aimés
    @gossips = Gossip.left_joins(:likes)
                     .group(:id)
                     .order('COUNT(likes.id) DESC')
                     .limit(5)
  end

  def team
  end

  def contact
  end
end