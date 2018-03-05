class ReportController < ApplicationController 
  
  def filter
  	
  end

  def get_params

  	date_ini = Date.civil(params[:date_ini][:year].to_i, params[:date_ini][:month].to_i, params[:date_ini][:day].to_i)
  	date_fin = Date.civil(params[:date_fin][:year].to_i, params[:date_fin][:month].to_i, params[:date_fin][:day].to_i)
  	option = params[:option]
    opt = params[:opt]

    if opt.present?
      @reporte = ReadFile.reporte(date_ini,date_fin,option,opt)
      puts @reporte
    elsif opt.blank?
      redirect_to report_filter_url
      flash[:notice] = "Seleccione una opción para consultar"
    end

  end

end
