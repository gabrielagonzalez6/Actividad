class ReportesController < ApplicationController
  before_action :set_reporte, only: [:show, :edit, :update, :destroy]

  def read_file
    require 'csv'

    csv_text = File.read(Rails.root.join('public', 'uploads', 'REPORTE.CSV'))
    
    if ! csv_text.valid_encoding?
      
      csv = csv_text.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
      csv.gsub(/dr/i,'med')
      csv = CSV.parse(csv, quote_char: '"', col_sep: ';', row_sep: :auto, headers: true)
      
    else
      csv = CSV.parse(csv_text, quote_char: '"', col_sep: ';', row_sep: :auto, headers: true)
    end
    
    csv.each do |row|
      r = Reporte.new
      r.fecha = row['Fecha']
      r.referencia = row['Referencia']
      if row['Descripcion']
        r.descripcion = row['Descripcion']
      elsif row['Descripción']
        r.descripcion = row['Descripción']
      elsif row['Descripci?n']
        r.descripcion = row['Descripci?n']
      end
      r.monto = row['Importe'] 
      r.saldo = row['Saldo']

      r.save
      puts "#{r.fecha}, #{r.descripcion}, #{r.monto} saved"
    end

    puts "There are now #{Reporte.count} rows in the transactions table"
  end

  def upload_file

    uploaded_io = params[:archivo]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    read_file
    redirect_to reportes_url
  
  end

  # GET /reportes
  # GET /reportes.json
  def index
    @reportes = Reporte.all
  end

  # GET /reportes/1
  # GET /reportes/1.json
  def show
  end

  # GET /reportes/new
  def new
    @reporte = Reporte.new
  end

  # GET /reportes/1/edit
  def edit
  end

  # POST /reportes
  # POST /reportes.json
  def create
    @reporte = Reporte.new(reporte_params)

    respond_to do |format|
      if @reporte.save
        format.html { redirect_to @reporte, notice: 'Reporte was successfully created.' }
        format.json { render :show, status: :created, location: @reporte }
      else
        format.html { render :new }
        format.json { render json: @reporte.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reportes/1
  # PATCH/PUT /reportes/1.json
  def update
    respond_to do |format|
      if @reporte.update(reporte_params)
        format.html { redirect_to @reporte, notice: 'Reporte was successfully updated.' }
        format.json { render :show, status: :ok, location: @reporte }
      else
        format.html { render :edit }
        format.json { render json: @reporte.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportes/1
  # DELETE /reportes/1.json
  def destroy
    @reporte.destroy
    respond_to do |format|
      format.html { redirect_to reportes_url, notice: 'Reporte was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reporte
      @reporte = Reporte.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reporte_params
      params.require(:reporte).permit(:fecha, :referencia, :descripcion, :monto, :saldo)
    end
end
