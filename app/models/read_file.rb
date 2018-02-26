class ReadFile < ApplicationRecord

	validates :referencia, uniqueness: true

    def self.reporte(date_ini,date_fin,option,opt)
		puts opt
		r = "fechas"

		if opt.include?r
			puts 'entra'
			puts date_ini
			puts date_fin
	      @reporte = ReadFile.where(fecha: date_ini..date_fin)
	  	else
	  		
	      d = Date.today
	  
	      if option == 'Hoy'
	        @reporte = ReadFile.where('fecha = ?', d.strftime('%F'))
	      elsif option == 'Mes'
	        @reporte = ReadFile.where('extract(month from fecha) = ? and extract(year from fecha) = ?', d.strftime('%m'), d.strftime('%Y'))
	      elsif option == 'Año'
	        @reporte = ReadFile.where('extract(year from fecha) = ?', d.strftime('%Y'))
	      end
  		end

	    return @reporte
   	end 
end
