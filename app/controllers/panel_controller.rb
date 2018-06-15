class PanelController < ApplicationController

  def index
    # tarjetas top
    @egresos_mes = MovMovimiento.egreso
          .where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)
          .sum(:total)
    @ingresos_mes = MovMovimiento.ingreso
          .where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)
          .sum(:total)
    @compras_pendientes = ComCompra.pendiente.count
    @usuarios_activos = User.all.count

    # grafico movimientos
    @movimientos_mxn_mes = {}
    (1..Time.now.end_of_month.day).to_a.each do |day|
      current_day = DateTime.new(Time.now.year,Time.now.month,day)
      @movimientos_mxn_mes[current_day.strftime('%Q')] = MovMovimiento.ingreso
      .joins(:emp_cuentab)
      .where('emp_cuentabs.moneda = ?', 0) # mxn
      .where(created_at: current_day)
      .sum(:total)
    end
  end
end
