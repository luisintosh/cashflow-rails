class EmpProveedorsController < ApplicationController
  load_and_authorize_resource
  before_action :set_emp_proveedor, only: [:show, :edit, :update, :destroy]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  # GET /emp_proveedors
  # GET /emp_proveedors.json
  def index
    # Filter
    scope = EmpProveedor.all.joins(:emp_perfil)
    scope = scope.like(params[:search]) if params[:search]

    @emp_proveedors = smart_listing_create :emp_proveedor,
                                           scope,
                                           partial: 'emp_proveedors/list',
                                           default_sort: {created_at: :desc},
                                           sort_attributes: [
                                               [:empresa, :empresa],
                                               [:saldo, :saldo],
                                               [:saldo_max, :saldo_max],
                                               [:tel_movil, 'emp_perfils.tel_movil'],
                                               [:tel_fijo, 'emp_perfils.tel_fijo'],
                                               [:email, 'emp_perfils.email'],
                                               [:created_at, :created_at],
                                               [:updated_at, :updated_at]
                                           ]
  end

  # GET /emp_proveedors/1
  # GET /emp_proveedors/1.json
  def show
  end

  # GET /emp_proveedors/new
  def new
    @emp_proveedor = EmpProveedor.new
    @emp_proveedor.build_emp_perfil
  end

  # GET /emp_proveedors/1/edit
  def edit
  end

  # POST /emp_proveedors
  # POST /emp_proveedors.json
  def create
    @emp_proveedor = EmpProveedor.new(emp_proveedor_params)

    respond_to do |format|
      if @emp_proveedor.save
        format.html { redirect_to @emp_proveedor, notice: 'Emp proveedor was successfully created.' }
        format.json { render :show, status: :created, location: @emp_proveedor }
      else
        format.html { render :new }
        format.json { render json: @emp_proveedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emp_proveedors/1
  # PATCH/PUT /emp_proveedors/1.json
  def update
    respond_to do |format|
      if @emp_proveedor.update(emp_proveedor_params)
        format.html { redirect_to @emp_proveedor, notice: 'Emp proveedor was successfully updated.' }
        format.json { render :show, status: :ok, location: @emp_proveedor }
      else
        format.html { render :edit }
        format.json { render json: @emp_proveedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emp_proveedors/1
  # DELETE /emp_proveedors/1.json
  def destroy
    @emp_proveedor.destroy
    respond_to do |format|
      format.html { redirect_to emp_proveedors_url, notice: 'Emp proveedor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emp_proveedor
      @emp_proveedor = EmpProveedor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emp_proveedor_params
      params.require(:emp_proveedor).permit(:empresa, :saldo, :saldo_max, :emp_perfil_id,
                                            emp_perfil_attributes: [:tel_fijo, :tel_movil, :email, :rfc, :direccion])
    end
end
