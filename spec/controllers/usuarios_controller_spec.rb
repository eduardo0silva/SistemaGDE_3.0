require 'spec_helper'

describe UsuariosController do
  integrate_views

  #deve usuar o objeto certo
  it "deve usar UsuariosController" do
    controller.should be_an_instance_of(UsuariosController)
  end
  
  describe "GET 'index'" do
  
    describe "para usuarios nao logados" do
      
      it "deve negar acesso" do
        get :index
        response.should redirect_to(login_path)
        flash[:notice].should =~ /Por favor/i
      end
    end
  
    describe "para usuarios cadastrados" do
    
      before(:each) do
        @usuario = test_login(Factory(:usuario))
      end
      
      it "deve obter sucesso" do
        get :index
        response.should be_success
      end
      
      it "deve conter o titulo certo" do
        get :index
        response.should have_tag("title", /Lista de Usuarios/i)
      end
      
      it "deve ter um elemento para cadas usuario" do
        segundo_usuario = Factory(:usuario, :email => "segundo_usuario@teste.com")
        terceiro_usuario = Factory(:usuario, :email => "terceiro_usuairo@teste.com")
        get :index
        [@usuario, segundo_usuario, terceiro_usuario].each do |usu|
          response.should have_tag("li", usu.nome)
        end
      end
      
      # TODO it "deve paginar usuarios" do
      #  30.times { Factory(:usuario, :email => Factory.next(:email))}
      #    get :index
      #    response.should have_tag("div[class='pagination']")
      #    response.should have_tag("span", "&laquo; Previous")
      #    response.should have_tag("span", "1")
      #    response.should have_tag("a[href=?]", "/usuarios?page=2", "2")
      #    response.should have_tag("a[href=?]", "/usuarios?page=2", "Next &raquo;")
      #  end
      
    end
    
  end

  describe "GET 'show'" do
    
    before(:each) do
      @usuario = Factory(:usuario)
      Usuario.stub!(:find, @usuario.id).and_return(@usuario)
    end
    
    it "deve obter sucesso" do
      get :show, :id => @usuario
      response.should be_success
    end
    
    it "deve ter titulo certo" do
      get :show, :id => @usuario
      response.should have_tag("title", /#{@usuario.nome}/)
    end
    
    it "deve incluir o nome do usuario" do
      get :show, :id => @usuario
      response.should have_tag("title", /#{@usuario.nome}/)
    end
    
    it "deve ter a imagem do perfil gravatar" do
      get :show, :id => @usuario
      response.should have_tag("div>img", :class => "gravatar")
    end
    
    #it "deve exibir os microposts do usuario" do
    #  mp1 = Factory(:micropost, :usuario => @usuario, :conteudo => "Foo bar Usuario Controller Spec")
    #  mp2 = Factory(:micropost, :usuario => @usuario, :conteudo => "Baz quux Usuario Controller Spec")
    #  get :show, :id => @usuario
    #  response.should have_tag("span.conteudo", mp1.conteudo)
    #  response.should have_tag("span.conteudo", mp2.conteudo)
    #end
    
  end

  describe "GET 'new'" do
    
    before(:each) do
      @usuario = Factory(:usuario)
    end
    
    it "deve retornar sucesso" do
      get :new
      response.should be_success
    end
    
    it "deve conter o titulo certo" do
      get :new
      response.should have_tag('title', /Cadastro/)
     end
    
  end

  describe "POST 'create'" do
    
    describe "falha" do
      
    before (:each) do
      @attr = {:nome => "", :email => "", :senha => "", :senha_confirmation => ""}
      @usuario = Factory.build(:usuario, @attr)
      Usuario.stub!(:new).and_return(@usuario)
    end
    
      it "não deve salvar o usuario" do
        @usuario.should_receive(:save).and_return(false)
        post :create, :usuario => @attr
      end
      
      it "deve renderizar a pagina 'Cadastro'" do
        post :create, :usuario => {}
        response.should render_template('new')
      end
      
      it "deve conter o titulo certo" do
        post :create, :usuario => {}
        response.should have_tag("title", /Cadastro/i)
      end
      
    end
  
    describe "sucesso" do
      
        before(:each) do
        @attr = { :nome => "Novo usuario", :email => "usaario@mandrake.com", :senha => "foobar", :senha_confirmation => "foobar" }
            @usuario = Factory.build(:usuario, @attr)
            Usuario.stub!(:new).and_return(@usuario)
        end

        it "deve salvar novo usuario" do
            @usuario.should_receive(:save).and_return(true)
            post :create, :usuario => @attr
        end

        it "deve redirecionar o usuario para pagina show" do
            post :create, :usuario => @attr
            response.should redirect_to(usuario_url(@usuario))
        end
        
        it "deve conter uma mensagem de boas vindas" do
          post :create, :usuario=>@attr
        #todo  response.should have_tag('div.content', /Bem vindo ao Projeto do IMI/i)
          #flash[:success] 'Bem vindo ao Projeto do IMI'
        end
        
        it "deve logar usuario com sucesso" do
          post :create, :usuario => @attr
          controller.should be_usuario_logado
        end
        
    end
    
  end
  
  describe "Get 'edit'" do
    
    before(:each) do
      @usuario = Factory(:usuario)
      test_login(@usuario)
    end
  
    it "deve obter sucesso" do
      get :edit, :id => @usuario
      response.should be_success
    end
  
    it "deve conter o titulo certo" do
      get :edit, :id => @usuario
      response.should have_tag("title", /Editando usuario/i)
    end
  
    it "deve conter um link para alterar o Gravatar" do
      get :edit, :id => @usuario
      gravatar_url = "http://gravatar.com/emails"
      response.should have_tag("a[href=?]", gravatar_url, /Alterar/i)
    end
  
  end
  
  describe "PUT 'atualizar'" do
    
    before(:each) do
      @usuario = Factory(:usuario)
      test_login(@usuario)
      Usuario.should_receive(:find).with(@usuario).and_return(@usuario)
    end
    
    describe "falha" do
      
      before(:each) do
        @invalido_attr = {:email => "", :nome => "" }
        @usuario.should_receive(:update_attributes).and_return(false)
      end
      
       it "deve renderizar a pagina de edicao" do
        put :update, :id => @usuario, :usuario => {}
        response.should render_template('edit')
      end
      
      it "deve conter o titulo certo" do
        put :update, :id => @usuario, :usuario => {}
        response.should have_tag("title", /Projeto de IMI | Editando Usu&aacute;rio/i)
      end
      
    end
    
    describe "sucesso" do
      
      before(:each) do
        @attr = {:nome => "Novo nome", :email => "usuario@prateste.org", :senha => "123456", :senha_confirmation => "123456"}
        @usuario.should_receive(:update_attributes).and_return(true)
      end
      
      it "deve redirecionar pra pagina visualizar usuario" do
        put :update, :id => @usuario, :usuario => @attr
        response.should redirect_to(usuario_path(@usuario))
      end
      
      it "deve conter a mensagem flash" do
        put :update, :id => @usuario, :usuario => @attr
        flash[:success].should =~ /Perfil atualizado/
      end
      
    end
    
  end
  
  describe "DELETE 'excluir'" do
  
   before(:each) do
      @usuario = Factory(:usuario)
    end
  
    describe "como um usuario nao logado" do
      it "deve negar acesso" do
        delete :destroy, :id => @usuario
        response.should redirect_to(login_path)
      end
    end
    
    describe "como usuaro logado nao admin" do
      it "deve proteger a pagina" do
        test_login(@usuario)
        delete :destroy, :id => @usuario
        response.should redirect_to(root_path)
      end
    end
    
    describe "simulando usuario admin" do
    
      before(:each) do
        admin = Factory(:usuario, :email => "admin@example.com", :admin => true)
        test_login(admin)
        Usuario.should_receive(:find).with(@usuario).and_return(@usuario)
        @usuario.should_receive(:destroy).and_return(@usuario)
      end
      
     it "deve excluir o usuario" do
        delete :destroy, :id => @usuario
        response.should redirect_to(usuarios_path)
      end
    
    end
    
  end
  
  describe "paginas de autenticacao e edit/update" do
    
    before (:each) do
      @usuario = Factory(:usuario)
    end
    
    describe "para usuarios nao logados" do
    
      it "deve negar acesso para 'edit'" do
        get :edit, :id => @usuario
        response.should redirect_to(login_path)
      end
      
      it "deve negar acesso para 'update'" do
        put :update, :id => @usuario, :usuario => {}
        response.should redirect_to(login_path)
      end
    
    end
    
    describe "para usuarios cadastrados" do
    
      before(:each) do
        usuario_errado = Factory(:usuario, :email => "usuario@testecadastro.com")
        test_login(usuario_errado)
      end
    
      it "deve requerer usuario correspondente para metodo 'edit'" do
        get :edit, :id => @usuario
        response.should redirect_to(root_path)
      end
      
      it "deve requerer usuario correspondente para metodo 'update'" do
        put :update, :id => @usuario, :usuario => {}
        response.should redirect_to(root_path)
      end
      
    end
    
  end
  
end