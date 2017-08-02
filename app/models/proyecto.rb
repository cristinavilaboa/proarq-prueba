class Proyecto < ApplicationRecord
	has_many :fotos, dependent: :destroy
end
