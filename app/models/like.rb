class Like < ApplicationRecord
  # Relations
  belongs_to :user
  belongs_to :gossip

  # Contrainte : un utilisateur ne peut liker un potin qu'une seule fois
  validates :user_id, uniqueness: { scope: :gossip_id }
end