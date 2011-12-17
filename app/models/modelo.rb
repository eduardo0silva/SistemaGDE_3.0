class Modelo < ActiveRecord::Base
  
  def self.save(upload)
    nome = upload['modelo'].original_filename
    diretorio = "public/modelos"
    
    #cria o caminho pro arquivo
    caminho = File.join(diretorio, nome)
    
    #Escreve o arquivo
    File.open(caminho, "wb"){ |f|
      f.write(upload['modelo'].read)
    }
  end
end
