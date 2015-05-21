#control de errores
class ErrorsController < ApplicationController
#ruta error 404  
  def routing
    render_404
  end
end