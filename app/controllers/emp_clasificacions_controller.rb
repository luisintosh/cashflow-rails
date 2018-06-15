class EmpClasificacionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_emp_clasificacion, only: [:show, :edit, :update, :destroy]

  # GET /emp_clasificacions
  # GET /emp_clasificacions.json
  def index
    @emp_clasificacions = EmpClasificacion.all
  end

  # GET /emp_clasificacions/1
  # GET /emp_clasificacions/1.json
  def show
  end

  # GET /emp_clasificacions/new
  def new
    @emp_clasificacion = EmpClasificacion.new
  end

  # GET /emp_clasificacions/1/edit
  def edit
  end

  # POST /emp_clasificacions
  # POST /emp_clasificacions.json
  def create
    @emp_clasificacion = EmpClasificacion.new(emp_clasificacion_params)

    respond_to do |format|
      if @emp_clasificacion.save
        format.html { redirect_to @emp_clasificacion, notice: 'Emp clasificacion was successfully created.' }
        format.json { render :show, status: :created, location: @emp_clasificacion }
      else
        format.html { render :new }
        format.json { render json: @emp_clasificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emp_clasificacions/1
  # PATCH/PUT /emp_clasificacions/1.json
  def update
    respond_to do |format|
      if @emp_clasificacion.update(emp_clasificacion_params)
        format.html { redirect_to @emp_clasificacion, notice: 'Emp clasificacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @emp_clasificacion }
      else
        format.html { render :edit }
        format.json { render json: @emp_clasificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emp_clasificacions/1
  # DELETE /emp_clasificacions/1.json
  def destroy
    @emp_clasificacion.destroy
    respond_to do |format|
      format.html { redirect_to emp_clasificacions_url, notice: 'Emp clasificacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emp_clasificacion
      @emp_clasificacion = EmpClasificacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emp_clasificacion_params
      params.require(:emp_clasificacion).permit(:nombre, :tipo_cuenta, :tipo_subcuenta, :tipo_movimiento)
    end
end
