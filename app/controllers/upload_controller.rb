class UploadController < ApplicationController
  
  def index
   # render :file => 'app\views\upload\uploadfile.rhtml'
  end
  
  def uploadFile
    post = Modelo.save(params[:upload])
    render :text => "Aquivo enviado com sucesso."
  end
  
end
