json.extract! reporte, :id, :fecha, :referencia, :descripcion, :monto, :saldo, :created_at, :updated_at
json.url reporte_url(reporte, format: :json)
