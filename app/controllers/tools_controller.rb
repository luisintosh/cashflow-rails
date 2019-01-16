class ToolsController < ApplicationController
  def uploadxls
    @doc = nil
    if request.post?
      uploaded_io = params[:xlsfile]
      if uploaded_io.original_filename.end_with? '.xlsx' or uploaded_io.original_filename.end_with? '.xls'
        @doc = SimpleXlsxReader.open(uploaded_io.path)
      else
        return redirect_to tools_uploadxls_path,
                           notice: 'Hubo un problema al leer el archivo, recuerda debe tener la extensión .xlsx'
      end
    end
  end
end
