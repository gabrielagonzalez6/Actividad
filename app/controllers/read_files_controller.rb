class ReadFilesController < ApplicationController
  before_action :set_read_file, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session

  require 'date'

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
      
      s = row['Fecha'].split("/")
      year = s[2].to_i + 2000
      format_fecha = Date.new(year, s[1].to_i, s[0].to_i).strftime("%F")

      r = ReadFile.new
      r.fecha = format_fecha
      # r.fecha = format_fecha.strftime("%F")
      # r.fecha = row['Fecha']

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

    puts "There are now #{ReadFile.count} rows in the transactions table"
  end

  def upload_file

    uploaded_io = params[:archivo]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    read_file
    redirect_to read_files_url
  
  end

  # GET /read_files
  # GET /read_files.json
  def index
    @read_files = ReadFile.all
  end

  # GET /read_files/1
  # GET /read_files/1.json
  def show
  end

  # GET /read_files/new
  def new
    @read_file = ReadFile.new
  end

  # GET /read_files/1/edit
  def edit
  end

  # POST /read_files
  # POST /read_files.json
  def create
    @read_file = ReadFile.new(read_file_params)

    respond_to do |format|
      if @read_file.save
        format.html { redirect_to @read_file, notice: 'Read file was successfully created.' }
        format.json { render :show, status: :created, location: @read_file }
      else
        format.html { render :new }
        format.json { render json: @read_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /read_files/1
  # PATCH/PUT /read_files/1.json
  def update
    respond_to do |format|
      if @read_file.update(read_file_params)
        format.html { redirect_to @read_file, notice: 'Read file was successfully updated.' }
        format.json { render :show, status: :ok, location: @read_file }
      else
        format.html { render :edit }
        format.json { render json: @read_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /read_files/1
  # DELETE /read_files/1.json
  def destroy
    @read_file.destroy
    respond_to do |format|
      format.html { redirect_to read_files_url, notice: 'Read file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_read_file
      @read_file = ReadFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def read_file_params
      params.require(:read_file).permit(:fecha, :referencia, :descripcion, :monto, :saldo)
    end
end
