require 'spec_helper'

describe PagesController do

  #Delete these examples and add some real ones
  it "should use PagesController" do
    controller.should be_an_instance_of(PagesController)
  end


  describe "GET 'principal'" do
    
    before(:each) do
       get :principal
     end
    
    it "deve obter sucesso" do
      response.should be_success
    end
    
    it "deve ter o titulo certo" do
      # TODO response.should have_tag("title", "Penna | Principal")
    end
      
  end

  describe "GET 'contato'" do
    
    before(:each) do
       get :contato
     end
     
    it "deve obter sucesso" do
      response.should be_success
    end
  end

  describe "GET 'sobre'" do
    
    before(:each) do
       get :sobre
     end
     
    it "deve obter sucesso" do
      response.should be_success
    end
  end
  
  describe "GET 'documento'" do
    
     before(:each) do
         get :documento
    end
       
    it "deve obter sucesso" do
      response.should be_success
    end
    
  end
  
end