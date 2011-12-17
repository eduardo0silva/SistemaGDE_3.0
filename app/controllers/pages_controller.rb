
class PagesController < ApplicationController

  #página principal
  def principal
    @titulo = "Principal"
    
    if usuario_logado?
      @documento = Documento.new
      @usuarios = Usuario.all
      @documentos = Documento.all
      @feed = usuario_corrente.feed.paginate(:page => params[:page])
    end
    
  end

  #pagina de contato
  def contato
    @titulo = "Contato"
  end
  
  #pagina sobre o site
  def sobre
    @titulo = "Sobre"
  end
  
  
  
end
