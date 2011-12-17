class SessionsController < ApplicationController
    
    def new
      @titulo = "Login"
    end

    def create
      @usuario = Usuario.authenticate(params[:session][:email], params[:session][:senha])
      if @usuario.nil?
        flash.now[:error] = "Inv&aacute;lida combina&ccedil;&atilde;o de email/senha."
        @titulo = "Login"
        render 'new'
      else
        usuario_logado @usuario
        redireciona_voltar_ou @usuario
      end
    end

    def destroy
      logout
      redirect_to root_path
    end
  

end
