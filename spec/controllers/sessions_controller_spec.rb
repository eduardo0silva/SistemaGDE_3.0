require 'spec_helper'

describe SessionsController do
  integrate_views

  #Teste inicial de criacao de objeto
  it "deve usar SessionsController" do
    controller.should be_an_instance_of(SessionsController)
  end


  describe "GET 'new'" do
    
    it "deve ser sucesso" do
      get :new
      response.should be_success
    end
    
    it "deve conter o titulo certo" do
      get :new
      response.should have_tag("title", /Login/i)
    end
    
  end
  
  describe "POST 'create'" do
  
    describe "login invalido" do
      
      before(:each) do
        @attr = {:email => "emailteste@teste.com", :senha => "senhaerro"}
        Usuario.should_receive(:authenticate).with(@attr[:email], @attr[:senha]).and_return(nil)
      end
      
      it "deve re-renderizar a pagina de cadastro" do
        post :create, :session => @attr
        response.should render_template('new')
      end
      
      it "deve conter o titulo certo" do
        post :create, :session => @attr
        response.should have_tag("title", /Login/i)
      end
    
    end
  
    describe "com email e senha validos" do
    
      before(:each) do
        @usuario = Factory(:usuario)
        @attr = {:email => @usuario.email, :senha => @usuario.senha}
        Usuario.should_receive(:authenticate).with(@usuario.email, @usuario.senha).and_return(@usuario)
      end
      
     it "deve realizar login do usuario" do
        post :create, :session => @attr
        controller.usuario_corrente.should == @usuario
        controller.should be_usuario_logado
      end
    
      it "deve redirecionar o usuario para pagina show" do
        post :create, :session => @attr
        redirect_to usuario_path(@usuario)
      end
    
    end
  
  end
  
    describe "DELETE 'destroy'" do
    
    it "deve deslogar o usuario logado" do
      test_login(Factory(:usuario))
      controller.should be_usuario_logado
      delete :destroy
      controller.should_not be_usuario_logado
      response.should redirect_to(root_path)
    end
  
  end
  
end