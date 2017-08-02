class Foto < ApplicationRecord
  belongs_to :proyecto
  validates :src, presence: true
end
