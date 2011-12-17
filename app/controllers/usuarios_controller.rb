class UsuariosController < ApplicationController
  before_filter :autenticar,      :only => [:index, :edit, :update, :destroy]
  before_filter :usuario_correto, :only => [:edit, :update]
  before_filter :usuario_admin,   :only => :destroy
  
  def show
    @usuario = Usuario.find(params[:id])
    @documentos = @usuario.documentos.paginate(:page => params[:page])
    @titulo = CGI.escapeHTML(@usuario.nome)
  end
  
  def new
    @usuario = Usuario.new
    @titulo = "Cadastro"
  end
  
  def create
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
      usuario_logado @usuario
      flash[:success] = "Bem vindo ao Projeto Penna"
      redirect_to @usuario
    else
      @titulo = "Cadastro"
      render 'new'
    end
  end
  
  def index
    @titulo = "Lista de Usuarios"
    @usuarios = Usuario.paginate(:page => params[:page])
  end
  
  def edit
    @titulo = "Editando usuario"
  end
  
  def update
    if @usuario.update_attributes(params[:usuario])
      flash[:success] = "Perfil atualizado."
      redirect_to @usuario
    else
      @titulo = "Editando Usu&aacute;rio"
      render 'edit'
    end
    
  end
  
  def destroy
    usuario = Usuario.find(params[:id]).destroy
    flash["success"] = "Usuario Excluido"
    redirect_to usuarios_path
  end
  
  private
  
  #removido para sessions_helper
 # def autenticar
  #  negar_acesso unless usuario_logado?
  #end
    
    def usuario_correto
      @usuario = Usuario.find(params[:id])
      redirect_to(root_path) unless usuario_corrente?(@usuario)
    end
    
    def usuario_admin
      redirect_to(root_path) unless usuario_corrente.admin?
    end
    
end
