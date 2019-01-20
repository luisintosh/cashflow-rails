class EmpleadosController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    error_404 unless can? :manage, User
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    error_404 unless can? :read, User
  end

  # GET /users/new
  def new
    error_404 unless can? :create, User
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    error_404 unless can? :update, User
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to empleado_path(@user.id), notice: 'Usuario creado correctamente.' }
        format.json { render :show, status: :created, location: empleado_path(@user.id) }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to empleado_path(@user.id), notice: 'Usuario actualizado correctamente.' }
        format.json { render :show, status: :ok, location: empleado_path(@user.id) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    error_404 unless can? :destroy, User
    @user.destroy
    respond_to do |format|
      format.html { redirect_to empleados_url, notice: 'Usuario eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:nombre, :role, :email, :password)
    end

    # Raise a new error 404 and doesn't render the content
    def error_404
      raise ActionController::RoutingError.new('Not Found')
    end
end
