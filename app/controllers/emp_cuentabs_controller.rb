class EmpCuentabsController < ApplicationController
  before_action :set_emp_cuentab, only: [:show, :edit, :update, :destroy]

  # GET /emp_cuentabs
  # GET /emp_cuentabs.json
  def index
    @emp_cuentabs = EmpCuentab.all
  end

  # GET /emp_cuentabs/1
  # GET /emp_cuentabs/1.json
  def show
  end

  # GET /emp_cuentabs/new
  def new
    @emp_cuentab = EmpCuentab.new
  end

  # GET /emp_cuentabs/1/edit
  def edit
  end

  # POST /emp_cuentabs
  # POST /emp_cuentabs.json
  def create
    @emp_cuentab = EmpCuentab.new(emp_cuentab_params)

    respond_to do |format|
      if @emp_cuentab.save
        format.html { redirect_to @emp_cuentab, notice: 'Emp cuentab was successfully created.' }
        format.json { render :show, status: :created, location: @emp_cuentab }
      else
        format.html { render :new }
        format.json { render json: @emp_cuentab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emp_cuentabs/1
  # PATCH/PUT /emp_cuentabs/1.json
  def update
    respond_to do |format|
      if @emp_cuentab.update(emp_cuentab_params)
        format.html { redirect_to @emp_cuentab, notice: 'Emp cuentab was successfully updated.' }
        format.json { render :show, status: :ok, location: @emp_cuentab }
      else
        format.html { render :edit }
        format.json { render json: @emp_cuentab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emp_cuentabs/1
  # DELETE /emp_cuentabs/1.json
  def destroy
    @emp_cuentab.destroy
    respond_to do |format|
      format.html { redirect_to emp_cuentabs_url, notice: 'Emp cuentab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emp_cuentab
      @emp_cuentab = EmpCuentab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emp_cuentab_params
      params.require(:emp_cuentab).permit(:nombre, :moneda, :saldo)
    end
end
