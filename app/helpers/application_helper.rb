module ApplicationHelper
  def titulo
      base_titulo = "Projeto Penna"
      if @titulo.nil?
        base_titulo
      else
        "#{base_titulo} | #{@titulo}"
      end
  end
  
  def logo
      image_tag("penna_logo.jpg", :alt => "Projeto Penna", :class => "logo")
  end
  
end
