module SessionsHelper
  
  def usuario_logado(usuario)
    usuario.lembre_me!
    cookies[:lembrar_token] = {:value => usuario.lembrar_token, :expires => 20.years.from_now.utc}
    self.usuario_corrente = usuario
  end
  
  def usuario_corrente=(usuario)
    @usuario_corrente = usuario
  end
  
  def usuario_corrente?(usuario)
    usuario == usuario_corrente
  end
  
  def usuario_corrente
    @usuario_corrente ||= usuario_from_lembrar_token
  end
  
  def usuario_from_lembrar_token
    lembrar_token = cookies[:lembrar_token]
    Usuario.find_by_lembrar_token(lembrar_token) unless lembrar_token.nil?
  end
  
  def usuario_logado?
    !usuario_corrente.nil?
  end
  
  def logout
    cookies.delete(:lembrar_token)
    self.usuario_corrente = nil 
  end
  
  def autenticar
    negar_acesso unless usuario_logado?
  end
  
  def negar_acesso
    armazena_uri
    flash[:notice] = "Por favor, deve ser cadastrado para acessar a esta p&aacute;gina."
    redirect_to login_path
  end
  
  def armazena_uri
    session[:return_to] = request.request_uri
  end
  
  def redireciona_voltar_ou(default)
    redirect_to(session[:return_to] || default)
    limpar_return_to
  end
  
  def limpar_return_to
    session[:return_to] = nil
  end
  
end



