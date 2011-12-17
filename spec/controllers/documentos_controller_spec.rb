require 'spec_helper'

describe DocumentosController do

  integrate_views

  # Teste de controle de acesso
  describe "controle de acesso" do
    
    it "deve negar acesso para create" do
      post :create
      response.should redirect_to(login_path)
    end
    
    it "deve negar acesso para destroy" do
      delete :destroy
      response.should redirect_to(login_path)
    end
    
    it "deve negar acesso para index lista de documentos" do
      get :index
      response.should redirect_to(login_path)
    end
    
    it "deve negar acesso para new novo documento" do
      get :new
      response.should redirect_to(login_path)
    end
    
    it "deve negar acesso para show exibicao de documentos" do
      get :show
      response.should redirect_to(login_path)
    end
    
    it "deve negar acesso para edit edicao de documentos" do
      get :edit
      response.should redirect_to(login_path)
    end
    
    it "deve negar acesso para update alteracao de documentos" do
      get :update
      response.should redirect_to(login_path)
    end
    
    it "deve negar acesso para gerar_documento de documentos" do
      get :gerar_documento
      response.should redirect_to(login_path)
    end
    it "deve negar acesso para lista_usuarios" do
      get :lista_usuarios
      response.should redirect_to(login_path)
    end
    
    
  end

end
