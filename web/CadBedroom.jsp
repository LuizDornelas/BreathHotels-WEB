<%-- 
    Document   : CadBedroom
    Created on : 26/09/2021, 19:46:06
    Author     : patri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <title>Cadastro de Quartos</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="view/styles/CadBedroom.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="signup-page">
  <div class="container">
    <div class="row">
      <div class="col-sm-10 col-lg-6 offset-sm-1 offset-lg-3">        
        <div class="form-bg">
          <a href="#"><img src="view/img/icons/BreathLogo.png" alt="logo" class="logo"></a>
          <h2>Cadastro de Quartos</h2>
          <form>
               
            <div class="form-group">
              <input type="text" name="quarto" class="form-control" placeholder="Quarto">
            </div>
            <div class="form-group">
              <input type="text" name="tipo" class="form-control" placeholder="Tipo">
            </div>
            <div class="form-group">
              <input type="text" name="camaSolteiro" class="form-control" placeholder="Número de camas de solteiro">
            </div>
            <div class="form-group">
              <input type="text" name="camaCasal" class="form-control" placeholder="Número de camas de casal">
            </div>
            <div class="form-group">
              <input type="text" name="diaria" class="form-control" placeholder="Valor da diária">
            </div>
            <div class="form-group">
              <button class="signup-btn">Cadastrar</button>
              </br></br>
              <a href="index.jsp">Voltar</a>
            </div>
            
          </form>
        </div>      
      </div>
    </div>
  </div>
</div>
</body>
</html>