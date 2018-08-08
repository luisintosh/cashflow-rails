class MovMovimientosController < ApplicationController
  load_and_authorize_resource
  before_action :set_mov_movimiento, only: [:show, :edit, :update, :destroy]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  # GET /mov_movimientos
  # GET /mov_movimientos.json
  def index
    # Filter
    scope = MovMovimiento.filters(params)

    @mov_movimientos = smart_listing_create :mov_movimiento,
                                         scope,
                                         partial: 'mov_movimientos/list',
                                         default_sort: {created_at: :desc},
                                         sort_attributes: [
                                             [:tipo_movimiento, :tipo_movimiento],
                                             [:hoja, :hoja],
                                             [:fecha, :fecha],
                                             [:ciclo, :ciclo],
                                             [:clasificacion, 'emp_clasificacions.nombre'],
                                             [:cuenta, 'emp_cuentabs.nombre'],
                                             [:concepto, :concepto],
                                             [:departamento, 'emp_locacions.nombre'],
                                             [:factura, :factura],
                                             [:comprobante, :comprobante],
                                             [:total, :total],
                                             [:created_at, :created_at],
                                             [:updated_at, :updated_at]
                                         ]
  end

  # GET /mov_movimientos/1
  # GET /mov_movimientos/1.json
  def show
  end

  # GET /mov_movimientos/new
  def new
    @mov_movimiento = MovMovimiento.new tipo_movimiento: params.fetch('type')
    @mov_movimiento.calcula_consecutivos
    @emp_cliente = EmpCliente.new
    @emp_proveedor = EmpProveedor.new
  end

  # GET /mov_movimientos/1/edit
  def edit
    @emp_cliente = EmpCliente.new
    @emp_proveedor = EmpProveedor.new
  end

  # POST /mov_movimientos
  # POST /mov_movimientos.json
  def create
    @mov_movimiento = MovMovimiento.new(mov_movimiento_params)
    save_and_add = params.fetch(:save_and_add) == '1' ? true : false

    respond_to do |format|
      if @mov_movimiento.save
        if save_and_add
          flash[:notice] = 'Movimiento creado correctamente.'
          format.html { redirect_to action: :new, type: @mov_movimiento.tipo_movimiento }
        else
          format.html { redirect_to @mov_movimiento }
        end

        format.json { render :show, status: :created, location: @mov_movimiento }
      else
        format.html { render :new }
        format.json { render json: @mov_movimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mov_movimientos/1
  # PATCH/PUT /mov_movimientos/1.json
  def update
    respond_to do |format|
      if @mov_movimiento.update(mov_movimiento_params)
        format.html { redirect_to @mov_movimiento, notice: 'Mov movimiento was successfully updated.' }
        format.json { render :show, status: :ok, location: @mov_movimiento }
      else
        format.html { render :edit }
        format.json { render json: @mov_movimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mov_movimientos/1
  # DELETE /mov_movimientos/1.json
  def destroy
    @mov_movimiento.destroy
    respond_to do |format|
      format.html { redirect_to mov_movimientos_url, notice: 'Mov movimiento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mov_movimiento
      @mov_movimiento = MovMovimiento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mov_movimiento_params
      params.require(:mov_movimiento).permit(:tipo_movimiento, :hoja, :fecha, :ciclo, :emp_clasificacion_id, :emp_cuentab_id, :concepto, :emp_proveedor_id, :emp_cliente_id, :emp_locacion_id, :factura, :comprobante, :tipo_comprobante, :subtotal, :iva, :ieps, :total)
    end
end
