json.extract! read_file, :id, :fecha, :referencia, :descripcion, :monto, :saldo, :created_at, :updated_at
json.url read_file_url(read_file, format: :json)
