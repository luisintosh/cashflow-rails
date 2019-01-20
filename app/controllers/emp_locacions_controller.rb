class EmpLocacionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_emp_locacion, only: [:show, :edit, :update, :destroy]

  # GET /emp_locacions
  # GET /emp_locacions.json
  def index
    @emp_locacions = EmpLocacion.all
  end

  # GET /emp_locacions/1
  # GET /emp_locacions/1.json
  def show
  end

  # GET /emp_locacions/new
  def new
    @emp_locacion = EmpLocacion.new
  end

  # GET /emp_locacions/1/edit
  def edit
  end

  # POST /emp_locacions
  # POST /emp_locacions.json
  def create
    @emp_locacion = EmpLocacion.new(emp_locacion_params)

    respond_to do |format|
      if @emp_locacion.save
        format.html { redirect_to @emp_locacion, notice: 'Departamento creado correctamente.' }
        format.json { render :show, status: :created, location: @emp_locacion }
      else
        format.html { render :new }
        format.json { render json: @emp_locacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emp_locacions/1
  # PATCH/PUT /emp_locacions/1.json
  def update
    respond_to do |format|
      if @emp_locacion.update(emp_locacion_params)
        format.html { redirect_to @emp_locacion, notice: 'Departamento actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @emp_locacion }
      else
        format.html { render :edit }
        format.json { render json: @emp_locacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emp_locacions/1
  # DELETE /emp_locacions/1.json
  def destroy
    @emp_locacion.destroy
    respond_to do |format|
      format.html { redirect_to emp_locacions_url, notice: 'Departamento eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emp_locacion
      @emp_locacion = EmpLocacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emp_locacion_params
      params.require(:emp_locacion).permit(:nombre, :direccion)
    end
end
