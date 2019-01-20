class ComArticulosController < ApplicationController
  load_and_authorize_resource
  before_action :set_com_articulo, only: [:show, :edit, :update, :destroy]

  # GET /com_articulos
  # GET /com_articulos.json
  def index
    @com_articulos = ComArticulo.all
  end

  # GET /com_articulos/1
  # GET /com_articulos/1.json
  def show
  end

  # GET /com_articulos/new
  def new
    @com_articulo = ComArticulo.new
    @com_articulo.crear_inventarios
  end

  # GET /com_articulos/1/edit
  def edit
  end

  # POST /com_articulos
  # POST /com_articulos.json
  def create
    @com_articulo = ComArticulo.new(com_articulo_params)

    respond_to do |format|
      if @com_articulo.save
        format.html { redirect_to @com_articulo, notice: 'Producto creado correctamente.' }
        format.json { render :show, status: :created, location: @com_articulo }
      else
        format.html { render :new }
        format.json { render json: @com_articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /com_articulos/1
  # PATCH/PUT /com_articulos/1.json
  def update
    respond_to do |format|
      if @com_articulo.update(com_articulo_params)
        format.html { redirect_to @com_articulo, notice: 'Producto actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @com_articulo }
      else
        format.html { render :edit }
        format.json { render json: @com_articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /com_articulos/1
  # DELETE /com_articulos/1.json
  def destroy
    @com_articulo.destroy
    respond_to do |format|
      format.html { redirect_to com_articulos_url, notice: 'Producto eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_com_articulo
      @com_articulo = ComArticulo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def com_articulo_params
      params.require(:com_articulo).permit(:codigo, :nombre, :categoria, :unidad_compra, :unidad_inventario,
                                           :cantidad_inventario, :precio_compra, :moneda, :iva, :ieps,
                                           :com_inventario_attributes => [
                                               :com_articulo_id, :emp_locacion_id, :stock, :stock_min, :_destroy, :id
                                           ])
    end
end
