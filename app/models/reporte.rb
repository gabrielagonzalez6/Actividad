class Reporte < ApplicationRecord

	validates :referencia, uniqueness: true
end
