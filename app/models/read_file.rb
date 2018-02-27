class ReadFile < ApplicationRecord

	validates :referencia, uniqueness: true

    def self.reporte(date_ini,date_fin,option,opt)
		puts opt
		f = "fechas"
		s = "seleccion"

		if opt.include?f
			puts 'entra'
			puts date_ini
			puts date_fin
	      @reporte = ReadFile.where(fecha: date_ini..date_fin).order(fecha: :desc, referencia: :desc)
	  	elsif opt.include?s
	  				
	      d = Date.today
	  
	      if option == 'Hoy'
	        @reporte = ReadFile.where('fecha = ?', d.strftime('%F')).order(referencia: :desc)
	      elsif option == 'Mes'
	        @reporte = ReadFile.where('extract(month from fecha) = ? and extract(year from fecha) = ?', d.strftime('%m'), d.strftime('%Y')).order(fecha: :desc, referencia: :desc)
	      elsif option == 'Año'
	        @reporte = ReadFile.where('extract(year from fecha) = ?', d.strftime('%Y')).order(fecha: :desc, referencia: :desc)
	      end

  		end

	    return @reporte
   	end 
end
