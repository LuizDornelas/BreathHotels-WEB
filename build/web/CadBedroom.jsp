<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Cadastro de Quartos</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="view/styles/CadUser.css">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
        %>    
        <div class="signup-page">
            <div class="container">
                <div class="row">
                    <div class="col-sm-10 col-lg-6 offset-sm-1 offset-lg-3">        
                        <div class="form-bg">
                            <a href="#"><img src="view/img/icons/BreathLogo.png" alt="logo" class="logo"></a>
                            <h2>Cadastro de Quartos</h2>
                            <form action="CadastroQuarto" method="POST">

                                <div class="form-group">
                                    <input type="text" name="quarto" maxlength="20" class="form-control" placeholder="Quarto">
                                </div>                                
                                <select name="tipo" class="form-select">
                                    <option disabled selected>Selecione o tipo de quarto</option>
                                    <option>Simples</option>                                                                                       
                                    <option>Luxo</option>  
                                </select><br><br>
                                <div class="form-group">
                                    <input type="number" min="0" id="number1" max="10" name="camaSolteiro" class="form-control" placeholder="Número de camas de solteiro" REQUIRED>
                                </div>
                                <div class="form-group">
                                    <input type="number" min="0" id="number2" max="10" name="camaCasal" class="form-control" placeholder="Número de camas de casal" REQUIRED>
                                </div>
                                <div class="form-group">
                                    <input type="number" min="50" id="number3" max="9999" name="diaria" class="form-control" placeholder="Valor da diária">
                                </div>              
                                <div class="form-group">
                                    <input class="btn btn-primary custom-btn" type="submit" name="acao" value="Cadastrar">
                                    <%
                                        //Traz a mensagem diretamente da control
                                        String msg = (String) request.getAttribute("msg");
                                        if (msg != null) {

                                    %>
                                    <font color="#274360"><%=msg%></font>
                                    <%}%>

                                    <div class="botoes">
                                        <a href="ListarQuarto">Voltar</a>  
                                    </div>
                                </div>
                            </form>
                        </div>      
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<script>
    // Select your input element.
    var number = document.getElementById('number1');
    var number2 = document.getElementById('number2');
    var number3 = document.getElementById('number3');

// Listen for input event on numInput.
    number.onkeydown = function (e) {
        if (!((e.keyCode === 190)
                || (e.keyCode >= 16 && e.keyCode <= 17)
                || (e.keyCode >= 37 && e.keyCode <= 40)
                || (e.keyCode >= 48 && e.keyCode <= 57)
                || (e.keyCode === 8))) {
            return false;
        }
    }
    number2.onkeydown = function (e) {
        if (!((e.keyCode === 190)
                || (e.keyCode >= 16 && e.keyCode <= 17)
                || (e.keyCode >= 37 && e.keyCode <= 40)
                || (e.keyCode >= 48 && e.keyCode <= 57)
                || (e.keyCode === 8))) {
            return false;
        }
    }
    number3.onkeydown = function (e) {
        if (!((e.keyCode >= 16 && e.keyCode <= 17)
                || (e.keyCode >= 37 && e.keyCode <= 40)
                || (e.keyCode >= 48 && e.keyCode <= 57)
                || (e.keyCode === 8))) {
            return false;
        }
    }
</script>
<%} else{
response.sendRedirect("indexCliente");
}%>