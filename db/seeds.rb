# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'admin@rohers.net', password: '123456', role: 1, nombre: 'Everardo Rodriguez')
User.create(email: 'empleado@rohers.net', password: '123456', role: 0, nombre: 'Juan Perez')
User.create(email: 'conta@rohers.net', password: '123456', role: 2, nombre: 'Matilda Martinez')


# Crea clasificaciones
clasificaciones = [
    ['COSTOS', 'COSTO DE VENTA', 'COMPRAS NACIONALES'],
    ['COSTOS', 'COSTO DE VENTA', 'COMPRAS NACIONALES / ABONO ORGÁNICO'],
    ['COSTOS', 'COSTO DE VENTA', 'COMPRAS NACIONALES / ACOLCHADO Y CINTILLA'],
    ['COSTOS', 'COSTO DE VENTA', 'COMPRAS NACIONALES / AGROLITA'],
    ['COSTOS', 'COSTO DE VENTA', 'COMPRAS NACIONALES / AGROQUÍMICOS Y FERTILIZANTES'],
    ['COSTOS', 'COSTO DE VENTA', 'COMPRAS NACIONALES / SUSTRATO'],
    ['GASTOS', 'GASTOS GENERALES', 'COMBUSTIBLES Y LUBRICANTES'],
    ['GASTOS', 'GASTOS GENERALES', 'AGUA'],
    ['GASTOS', 'GASTOS GENERALES', 'AJUSTE'],
    ['GASTOS', 'GASTOS GENERALES', 'ANÁLISIS'],
    ['GASTOS', 'GASTOS GENERALES', 'LIMPIEZA'],
    ['GASTOS', 'GASTOS GENERALES', 'CAPACITACIÓN AL PERSONAL'],
    ['ACTIVO', 'ACTIVO A LARGO PLAZO', 'MAQUINARIA Y EQUIPO'],
    ['RESULTADO INTEGRAL DE FINANCIAMIENTO', 'GASTOS FINANCIEROS', 'COMISIONES BANCARIAS'],
    ['PASIVO', 'PASIVO A LARGO PLAZO', 'CUENTAS POR PAGAR'],
    ['GASTOS', 'GASTOS GENERALES', 'CUOTAS IMSS'],
    ['GASTOS', 'GASTOS GENERALES', 'APORTACIONES AL INFONAVIT'],
    ['GASTOS', 'GASTOS GENERALES', 'APORTACIONES AL SAR'],
    ['ACTIVO', 'ACTIVO A LARGO PLAZO', 'EQUIPO DE CÓMPUTO'],
    ['ACTIVO', 'ACTIVO A LARGO PLAZO', 'MOBILIARIO Y EQUIPO DE OFICINA'],
    ['ACTIVO', 'ACTIVO A LARGO PLAZO', 'EQUIPO DE COMUNICACIÓN'],
    ['ACTIVO', 'ACTIVO A LARGO PLAZO', 'EQUIPO DE TRANSPORTE'],
    ['GASTOS', 'GASTOS GENERALES', 'MANTENIMIENTO Y CONSERVACIÓN'],
    ['GASTOS', 'GASTOS GENERALES', 'MANTENIMIENTO Y CONSERVACIÓN / FERRETERIA Y MATERIALES'],
    ['GASTOS', 'GASTOS GENERALES', 'HONORARIOS ADUANALES'],
    ['GASTOS', 'GASTOS GENERALES', 'HONORARIOS '],
    ['GASTOS', 'GASTOS GENERALES', 'PREDIAL'],
    ['GASTOS', 'GASTOS GENERALES', 'IMPUESTO ESTATAL SOBRE NÓMINAS'],
    ['GASTOS', 'GASTOS GENERALES', 'TENENCIA, PLACAS'],
    ['GASTOS', 'GASTOS GENERALES', 'RECARGOS FISCALES'],
    ['GASTOS', 'GASTOS GENERALES', 'OTROS IMPUESTOS'],
    ['GASTOS', 'GASTOS GENERALES', 'INFRACCIONES'],
    ['PASIVO', 'PASIVO A CORTO PLAZO', 'INTERESES POR PAGAR'],
    ['GASTOS', 'GASTOS GENERALES', 'ENERGÍA ELÉCTRICA'],
    ['INGRESOS', 'INGRESOS PROPIOS', 'MAQUILA PLANTULA'],
    ['GASTOS', 'GASTOS GENERALES', 'HONORARIOS'],
    ['INGRESOS', 'OTROS INGRESOS', 'MOVIMIENTO INTERNO'],
    ['GASTOS', 'GASTOS GENERALES', 'SUELDOS Y SALARIOS'],
    ['GASTOS', 'GASTOS GENERALES', 'TIEMPOS EXTRAS'],
    ['GASTOS', 'GASTOS GENERALES', 'VACACIONES'],
    ['GASTOS', 'GASTOS GENERALES', 'PRIMA VACACIONAL'],
    ['GASTOS', 'GASTOS GENERALES', 'AGUINALDO'],
    ['GASTOS', 'OTROS GASTOS GENERALES', 'OTROS GASTOS'],
    ['INGRESOS', 'OTROS INGRESOS', 'OTROS INGRESOS'],
    ['GASTOS', 'GASTOS GENERALES', 'PAPELERÍA Y ARTÍCULOS DE OFICINA'],
    ['GASTOS', 'GASTOS GENERALES', 'FLETES Y ACARREOS'],
    ['GASTOS', 'OTROS GASTOS GENERALES', 'PERSONAL'],
    ['ACTIVO', 'ACTIVO A CORTO PLAZO', 'DEUDORES DIVERSOS'],
    ['GASTOS', 'GASTOS GENERALES', 'RENTA'],
    ['CAPITAL', 'RESULTADO DE EJERCICIOS ANTERIORES', 'UTILIDAD/PÉRDIDA AÑO'],
    ['GASTOS', 'GASTOS GENERALES', 'SEGUROS Y FIANZAS'],
    ['GASTOS', 'GASTOS GENERALES', 'TARJETAS'],
    ['GASTOS', 'GASTOS GENERALES', 'COMISIONES POR TARJETAS DE CRÉDITO'],
    ['GASTOS', 'GASTOS GENERALES', 'TELÉFONO E INTERNET'],
    ['INGRESOS', 'OTROS INGRESOS', 'VENTA DE AGROQUÍMICOS'],
    ['INGRESOS', 'INGRESOS PROPIOS', 'VENTA DE HORTALIZAS'],
    ['INGRESOS', 'INGRESOS PROPIOS', 'VENTA DE PLANTULA'],
    ['INGRESOS', 'INGRESOS PROPIOS', 'VENTA DE SEMILLA'],
    ['INGRESOS', 'INGRESOS PROPIOS', 'EXPORTACIÓN VENTA DE HORTALIZAS'],
    ['GASTOS', 'GASTOS GENERALES', 'VIGILANCIA Y SEGURIDAD'],
    ['ACTIVO', 'ACTIVO A LARGO PLAZO', 'TERRENOS'],
    ['GASTOS', 'GASTOS GENERALES', 'VIÁTICOS'],
    ['COSTOS', 'COSTO DE VENTA', 'SEMILLA PARA VENTA'],
    ['RESULTADO INTEGRAL DE FINANCIAMIENTO', 'GASTOS FINANCIEROS', 'DIVISAS'],
    ['GASTOS', 'GASTOS GENERALES', 'GASTOS DE IMPORTACIÓN'],
    ['GASTOS', 'GASTOS GENERALES', 'GASTOS DE EXPORTACIÓN'],
    ['PASIVO', 'PASIVO A CORTO PLAZO', 'DIVIDENDOS POR PAGAR'],
    ['INGRESOS', 'OTROS INGRESOS', 'VENTA DE ACTIVO'],
    ['GASTOS', 'GASTOS GENERALES', 'HONORARIOS A PROYECTOS'],
    ['INGRESOS', 'INGRESOS PROPIOS', 'DEVOLUCIONES Y DESCUENTOS SOBRE VENTA'],
    ['COSTOS', 'COMPRAS', 'DEVOLUCIONES Y DESCUENTOS SOBRE COMPRA']
]

clasificaciones.each do |item|
  if item[0] == 'COSTOS' or item[0] == 'GASTOS'
    tipo_mov = 'ENTRADA'
  else
    tipo_mov = 'SALIDA'
  end
  EmpClasificacion.create nombre: item[2], tipo_cuenta: item[0], tipo_subcuenta: item[1], tipo_movimiento: tipo_mov
end

# Crea locaciones
EmpLocacion.create nombre: 'Almacen/Oficinas', direccion: 'Zona Centro, Rioverde, SLP'
EmpLocacion.create nombre: 'La Soledad', direccion: 'Sanguijuela, San Luis Potosí'
EmpLocacion.create nombre: 'Semillero', direccion: 'Sanguijuela, Rioverde, SLP'
EmpLocacion.create nombre: 'Rancho Alegre', direccion: 'Llanitos, Cd. Fernández, SLP'

# Crea cuentas
EmpCuentab.create nombre: 'CAJA CHICA', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'ROHERS SANTANDER 6109', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'ROHERS MONEX USD 0429', moneda: 'USD', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'ROHERS MONEX MXN 0429', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'MARCIAL HSBC 3631', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'MARCIAL BANAMEX 9327', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'EVERARDO BANCOPPEL 6417', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'EVERARDO SANTANDER 8964', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'EVERARDO CAJA CHICA', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'GREENHOUSE MONEX USD 1748', moneda: 'USD', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'GREENHOUSE MONEX MXN 1748', moneda: 'MXN', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'GREENHOUSE CAJA CHICA USD', moneda: 'USD', saldo: Faker::Number.number(5)
EmpCuentab.create nombre: 'GREENHOUSE CAJA CHICA MXN', moneda: 'MXN', saldo: Faker::Number.number(5)

# Proveedores
50.times do |i|
  m = EmpProveedor.new
  m.build_emp_perfil
  m.empresa = Faker::Company.name
  m.saldo = 0.0
  m.saldo_max = 0.0
  m.emp_perfil.tel_fijo = Faker::Number.number(10)
  m.emp_perfil.tel_movil = Faker::Number.number(10)
  m.emp_perfil.email = Faker::Internet.email
  m.emp_perfil.direccion = Faker::Address.street_address
  m.save
end

# Clientes
50.times do |i|
  m = EmpCliente.new
  m.build_emp_perfil
  m.nombre = Faker::Name.first_name
  m.apellidos = Faker::Name.last_name
  m.saldo = 0.0
  m.saldo_max = 0.0
  m.emp_perfil.tel_fijo = Faker::Number.number(10)
  m.emp_perfil.tel_movil = Faker::Number.number(10)
  m.emp_perfil.email = Faker::Internet.email
  m.emp_perfil.direccion = Faker::Address.street_address
  m.save
end

# Movimientos
hoja = 150
200.times do |i|
  m = MovMovimiento.new
  m.tipo_movimiento = rand(2)
  m.hoja = (i/10)+100
  m.fecha = (i < 100) ? Faker::Date.between(Time.new(2017,6,1), Time.new(2017,12,30)) : Faker::Date.between(Time.new(2018,1,1), Time.new(2018,6,30))
  m.ciclo = (i < 100) ? '2017-B' : '2018-A'
  if i % 2
    m.emp_clasificacion = EmpClasificacion.where(tipo_movimiento: 'ENTRADA').sample
    m.emp_cliente = EmpCliente.all.sample
  else
    m.emp_clasificacion = EmpClasificacion.where(tipo_movimiento: 'SALIDA').sample
    m.emp_proveedors = EmpProveedor.all.sample
  end
  m.emp_cuentab = EmpCuentab.all.sample
  m.concepto = Faker::Lorem.sentence(3)
  m.emp_locacion = EmpLocacion.all.sample
  m.factura = Faker::Code.isbn
  m.comprobante = Faker::Code.asin
  m.tipo_comprobante = rand(6)
  m.subtotal = Faker::Number.decimal(4, 3)
  m.iva = m.subtotal * 0.16
  m.ieps = rand(10)==5 ? (m.subtotal * 0.1) : 0.0
  m.total = m.subtotal + m.iva + m.ieps
  m.created_at = m.fecha
  #m.updated_at = rand(10)==5 ? m.fecha + 1.day : m.fecha
  begin
    m.save
  rescue
  end

end

# Articulos e inventario
50.times do |i|
  a = ComArticulo.new
  a.codigo = (i+1).to_s + Faker::Number.number(4)
  a.nombre = Faker::Commerce.product_name
  a.categoria = Faker::Commerce.department(1)
  a.unidad_compra = ComArticulo.unidades.sample
  a.unidad_inventario = ComArticulo.unidades.sample
  a.cantidad_inventario = Faker::Number.number(2)
  a.iva = 16

  a.crear_inventarios
  a.com_inventario.each do |inv|
    inv.stock = Faker::Number.number(3)
    inv.stock_min = 10
  end

  begin
    a.save
  rescue
  end
end
