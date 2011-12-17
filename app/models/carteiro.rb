class Carteiro < ActionMailer::Base
  
  def padrao(corpo, assunto, email = "eduardo.silva@ccabr.intraer", reponder = "eduardo.silva@ccabr.intraer")
    recipients email
    from "Edu <eduardo.silva@ccabr.intraer>"
    subject assunto
    reply_to reponder
    body :corpo => corpo
  end
end
