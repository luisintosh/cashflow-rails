# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180821004639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "com_articulos", force: :cascade do |t|
    t.string "codigo"
    t.string "nombre"
    t.string "categoria"
    t.string "unidad_compra"
    t.string "unidad_inventario"
    t.decimal "cantidad_inventario", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "iva", precision: 5, scale: 2, default: "0.0"
    t.decimal "ieps", precision: 5, scale: 2, default: "0.0"
  end

  create_table "com_compras", force: :cascade do |t|
    t.string "ciclo"
    t.bigint "emp_clasificacion_id"
    t.bigint "emp_proveedor_id"
    t.integer "estado", default: 0
    t.date "fecha"
    t.string "factura"
    t.decimal "descuento", precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "totales"
    t.string "totales_por_comprobante"
    t.index ["emp_clasificacion_id"], name: "index_com_compras_on_emp_clasificacion_id"
    t.index ["emp_proveedor_id"], name: "index_com_compras_on_emp_proveedor_id"
  end

  create_table "com_det_compras", force: :cascade do |t|
    t.bigint "com_compra_id"
    t.bigint "com_articulo_id"
    t.bigint "emp_locacion_id"
    t.decimal "cantidad", precision: 10, scale: 2, default: "0.0"
    t.decimal "precio", precision: 10, scale: 2, default: "0.0"
    t.integer "moneda"
    t.decimal "descuento", precision: 5, scale: 2, default: "0.0"
    t.boolean "inventariar", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "iva", precision: 5, scale: 2, default: "0.0"
    t.decimal "ieps", precision: 5, scale: 2, default: "0.0"
    t.string "comprobante"
    t.integer "tipo_comprobante"
    t.index ["com_articulo_id"], name: "index_com_det_compras_on_com_articulo_id"
    t.index ["com_compra_id"], name: "index_com_det_compras_on_com_compra_id"
    t.index ["emp_locacion_id"], name: "index_com_det_compras_on_emp_locacion_id"
  end

  create_table "com_inventarios", force: :cascade do |t|
    t.bigint "com_articulo_id"
    t.bigint "emp_locacion_id"
    t.decimal "stock", precision: 10, scale: 2, default: "0.0"
    t.decimal "stock_min", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["com_articulo_id"], name: "index_com_inventarios_on_com_articulo_id"
    t.index ["emp_locacion_id"], name: "index_com_inventarios_on_emp_locacion_id"
  end

  create_table "com_pagos", force: :cascade do |t|
    t.bigint "com_compra_id"
    t.bigint "mov_movimiento_id"
    t.bigint "emp_cuentab_id"
    t.bigint "emp_locacion_id"
    t.decimal "monto", precision: 10, scale: 2, default: "0.0"
    t.integer "tipo_pago"
    t.string "hoja"
    t.string "concepto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "comprobante"
    t.index ["com_compra_id"], name: "index_com_pagos_on_com_compra_id"
    t.index ["emp_cuentab_id"], name: "index_com_pagos_on_emp_cuentab_id"
    t.index ["emp_locacion_id"], name: "index_com_pagos_on_emp_locacion_id"
    t.index ["mov_movimiento_id"], name: "index_com_pagos_on_mov_movimiento_id"
  end

  create_table "emp_clasificacions", force: :cascade do |t|
    t.string "nombre"
    t.string "tipo_cuenta"
    t.string "tipo_subcuenta"
    t.integer "tipo_movimiento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emp_clientes", force: :cascade do |t|
    t.string "nombre"
    t.string "apellidos"
    t.decimal "saldo", precision: 10, scale: 2, default: "0.0"
    t.decimal "saldo_max", precision: 10, scale: 2, default: "0.0"
    t.bigint "emp_perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emp_perfil_id"], name: "index_emp_clientes_on_emp_perfil_id"
  end

  create_table "emp_cuentabs", force: :cascade do |t|
    t.string "nombre"
    t.integer "moneda"
    t.decimal "saldo", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emp_locacions", force: :cascade do |t|
    t.string "nombre"
    t.string "direccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emp_perfils", force: :cascade do |t|
    t.string "tel_fijo"
    t.string "tel_movil"
    t.string "email"
    t.string "rfc"
    t.string "direccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emp_proveedors", force: :cascade do |t|
    t.string "empresa"
    t.decimal "saldo", precision: 10, scale: 2
    t.decimal "saldo_max", precision: 10, scale: 2
    t.bigint "emp_perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emp_perfil_id"], name: "index_emp_proveedors_on_emp_perfil_id"
  end

  create_table "mov_movimientos", force: :cascade do |t|
    t.integer "tipo_movimiento"
    t.string "hoja"
    t.date "fecha"
    t.string "ciclo"
    t.bigint "emp_clasificacion_id"
    t.bigint "emp_cuentab_id"
    t.string "concepto"
    t.bigint "emp_proveedor_id"
    t.bigint "emp_cliente_id"
    t.bigint "emp_locacion_id"
    t.string "factura"
    t.string "comprobante"
    t.integer "tipo_comprobante"
    t.decimal "subtotal", precision: 10, scale: 2, default: "0.0"
    t.decimal "iva", precision: 10, scale: 2, default: "0.0"
    t.decimal "ieps", precision: 10, scale: 2, default: "0.0"
    t.decimal "total", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emp_clasificacion_id"], name: "index_mov_movimientos_on_emp_clasificacion_id"
    t.index ["emp_cliente_id"], name: "index_mov_movimientos_on_emp_cliente_id"
    t.index ["emp_cuentab_id"], name: "index_mov_movimientos_on_emp_cuentab_id"
    t.index ["emp_locacion_id"], name: "index_mov_movimientos_on_emp_locacion_id"
    t.index ["emp_proveedor_id"], name: "index_mov_movimientos_on_emp_proveedor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "com_compras", "emp_clasificacions"
  add_foreign_key "com_compras", "emp_proveedors"
  add_foreign_key "com_det_compras", "com_articulos"
  add_foreign_key "com_det_compras", "com_compras"
  add_foreign_key "com_det_compras", "emp_locacions"
  add_foreign_key "com_inventarios", "com_articulos"
  add_foreign_key "com_inventarios", "emp_locacions"
  add_foreign_key "com_pagos", "com_compras"
  add_foreign_key "com_pagos", "emp_cuentabs"
  add_foreign_key "com_pagos", "emp_locacions"
  add_foreign_key "com_pagos", "mov_movimientos"
  add_foreign_key "emp_clientes", "emp_perfils"
  add_foreign_key "emp_proveedors", "emp_perfils"
  add_foreign_key "mov_movimientos", "emp_clasificacions"
  add_foreign_key "mov_movimientos", "emp_clientes"
  add_foreign_key "mov_movimientos", "emp_cuentabs"
  add_foreign_key "mov_movimientos", "emp_locacions"
  add_foreign_key "mov_movimientos", "emp_proveedors"
end
