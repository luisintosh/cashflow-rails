class ComComprasController < ApplicationController
  load_and_authorize_resource
  before_action :set_com_compra, only: [:show, :edit, :update, :destroy]
  before_action :set_relation_data, only: [:new, :edit, :create, :update]

  # GET /com_compras
  # GET /com_compras.json
  def index
    @com_compras = ComCompra.all.order id: :desc

    @comp_pendientes = ComCompra.pendiente.count
    @deudas = ComCompra.suma_total_adeudos
  end

  # GET /com_compras/1
  # GET /com_compras/1.json
  def show
  end

  # GET /com_compras/new
  def new
    @com_compra = ComCompra.new
  end

  # GET /com_compras/1/edit
  def edit
  end

  # POST /com_compras
  # POST /com_compras.json
  def create
    @com_compra = ComCompra.new(com_compra_params)
    respond_to do |format|
      if @com_compra.save
        format.html { redirect_to @com_compra, notice: 'Com compra was successfully created.' }
        format.json { render :show, status: :created, location: @com_compra }
      else
        format.html { render :new }
        format.json { render json: @com_compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /com_compras/1
  # PATCH/PUT /com_compras/1.json
  def update
    respond_to do |format|
      if @com_compra.update(com_compra_params)
        format.html { redirect_to @com_compra, notice: 'Com compra was successfully updated.' }
        format.json { render :show, status: :ok, location: @com_compra }
      else
        format.html { render :edit }
        format.json { render json: @com_compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /com_compras/1
  # DELETE /com_compras/1.json
  def destroy
    @com_compra.destroy
    respond_to do |format|
      format.html { redirect_to com_compras_url, notice: 'Com compra was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /com_compras/com_pagos/multipago
  # Marca como pagado las compras enviadas
  def multipago
    @ids = params[:ids]
    if @ids.blank?
      raise 'No existe IDs'
    else
      @ids = @ids.split(',')
    end

    unless @ids.kind_of? Array
      raise 'No es un arreglo de IDs'
    end

    @ids = ComCompra.find(@ids)
  end

  # POST /com_compras/com_pagos/multipago
  # Inicia el pago de multiples cuentas
  def multipago_guardar
    if ComCompra.marcar_pagado(params)
      redirect_to com_compras_path, notice: 'Pagos generados correctamente.'
    else
      redirect_to :back, notice: 'Exite un error con las cuentas de pago'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_com_compra
      @com_compra = ComCompra.find(params[:id])
    end

    def set_relation_data
      @com_locaciones = EmpLocacion.all
      @com_articulos = ComArticulo.all.map(&:attributes).each{|e| e[:text]="#{e['codigo']} - #{e['nombre']}"}.to_json
      @com_articulo = ComArticulo.new
      @com_articulo.crear_inventarios
      @emp_proveedor = EmpProveedor.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def com_compra_params
      params.require(:com_compra).permit(:ciclo, :emp_clasificacion_id, :emp_proveedor_id, :estado, :fecha, :factura,
                                         :descuento, :com_det_compra_attributes => [
              :com_articulo_id, :emp_locacion_id, :cantidad, :precio, :moneda, :descuento, :inventariar, :iva, :ieps,
              :comprobante, :tipo_comprobante, :_destroy, :id
          ])
    end
end
