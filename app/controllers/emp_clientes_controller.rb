class EmpClientesController < ApplicationController
  before_action :set_emp_cliente, only: [:show, :edit, :update, :destroy]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  # GET /emp_clientes
  # GET /emp_clientes.json
  def index
    # Filter
    scope = EmpCliente.all.joins(:emp_perfil)
    scope = scope.like(params[:search]) if params[:search]

    @emp_clientes = smart_listing_create :emp_cliente,
                                           scope,
                                           partial: 'emp_clientes/list',
                                           default_sort: {created_at: :desc},
                                           sort_attributes: [
                                               [:nombre, :nombre],
                                               [:apellidos, :apellidos],
                                               [:saldo, :saldo],
                                               [:saldo_max, :saldo_max],
                                               [:tel_movil, 'emp_perfils.tel_movil'],
                                               [:tel_fijo, 'emp_perfils.tel_fijo'],
                                               [:email, 'emp_perfils.email'],
                                               [:created_at, :created_at],
                                               [:updated_at, :updated_at]
                                           ]
  end

  # GET /emp_clientes/1
  # GET /emp_clientes/1.json
  def show
  end

  # GET /emp_clientes/new
  def new
    @emp_cliente = EmpCliente.new
    @emp_cliente.build_emp_perfil
  end

  # GET /emp_clientes/1/edit
  def edit
  end

  # POST /emp_clientes
  # POST /emp_clientes.json
  def create
    @emp_cliente = EmpCliente.new(emp_cliente_params)

    respond_to do |format|
      if @emp_cliente.save
        format.html { redirect_to @emp_cliente, notice: 'Emp cliente was successfully created.' }
        format.json { render :show, status: :created, location: @emp_cliente }
      else
        format.html { render :new }
        format.json { render json: @emp_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emp_clientes/1
  # PATCH/PUT /emp_clientes/1.json
  def update
    respond_to do |format|
      if @emp_cliente.update(emp_cliente_params)
        format.html { redirect_to @emp_cliente, notice: 'Emp cliente was successfully updated.' }
        format.json { render :show, status: :ok, location: @emp_cliente }
      else
        format.html { render :edit }
        format.json { render json: @emp_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emp_clientes/1
  # DELETE /emp_clientes/1.json
  def destroy
    @emp_cliente.destroy
    respond_to do |format|
      format.html { redirect_to emp_clientes_url, notice: 'Emp cliente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emp_cliente
      @emp_cliente = EmpCliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emp_cliente_params
      params.require(:emp_cliente).permit(:nombre, :apellidos, :saldo, :saldo_max, :emp_perfil_id,
                                          emp_perfil_attributes: [:tel_fijo, :tel_movil, :email, :rfc, :direccion])
    end
end
