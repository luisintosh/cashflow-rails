class ComPagosController < ApplicationController
  load_and_authorize_resource
  before_action :set_com_pago, only: [:show, :edit, :update, :destroy]

  # GET /com_pagos
  # GET /com_pagos.json
  def index
    @com_compra = ComCompra.find params[:com_compra_id]
    @com_pagos = ComPago.where(com_compra_id: params[:com_compra_id]).order(id: :desc)
  end

  # GET /com_pagos/1
  # GET /com_pagos/1.json
  def show
  end

  # GET /com_pagos/new
  def new
    @com_pago = ComPago.new
    @com_pago.com_compra = ComCompra.find params[:com_compra_id]
    @com_pago.datos_default
  end

  # GET /com_pagos/1/edit
  def edit
  end

  # POST /com_pagos
  # POST /com_pagos.json
  def create
    @com_pago = ComPago.new(com_pago_params)

    respond_to do |format|
      if @com_pago.save
        format.html { redirect_to @com_pago, com_compra_id: @com_pago.com_compra_id, notice: 'Pago creado correctamente.' }
        format.json { render :show, status: :created, location: @com_pago }
      else
        format.html { render :new }
        format.json { render json: @com_pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /com_pagos/1
  # PATCH/PUT /com_pagos/1.json
  def update
    respond_to do |format|
      if @com_pago.update(com_pago_params)
        format.html { redirect_to @com_pago, com_compra_id: @com_pago.com_compra_id, notice: 'Pago actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @com_pago }
      else
        format.html { render :edit }
        format.json { render json: @com_pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /com_pagos/1
  # DELETE /com_pagos/1.json
  def destroy
    compra_id = @com_pago.com_compra.id
    @com_pago.destroy
    respond_to do |format|
      format.html { redirect_to com_pagos_path(com_compra_id: compra_id), notice: 'Pago eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_com_pago
      @com_pago = ComPago.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def com_pago_params
      params.require(:com_pago).permit(:com_compra_id, :mov_movimiento_id, :emp_cuentab_id, :monto,
                                       :tipo_pago, :hoja, :concepto, :comprobante)
    end
end
