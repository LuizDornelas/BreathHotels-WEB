<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="pt-BR">
    <head>
        <title>Cadastro de Quartos</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="view/styles/CadUser.css">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico">
        <link rel="stylesheet" type="text/css" href="view/styles/Estoque.css">        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    </head>
    <body class="conteudo">
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
        %>  
        <header>
            <nav style="background-color: #274360; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); height: 100px; margin-bottom: 5vw;">
                <div class="nav-wrapper">
                    <a href="#" class="brand-logo">
                        <img src="view/img/icons/BreathHotels-logo-white.png" alt="logo" style="width: 250px; margin: 10px; ">
                    </a>
                    <ul id="nav-mobile" class="right hide-on-med-and-down" style="margin-left: 1vw; margin-top: 2vw; font-size: 20px; ">
                        <li><a href="index" style="margin-right: 2vw; margin-bottom: 1vw; font-size: 20px; color: rgb(255,255,255,0.6)!important;">HOME</a></li>
                    </ul>
                </div>
            </nav>
        </header>

        <div class="row" style="width: 95%;">
            <center>
                <form action="CadastroQuarto" method="POST">   
                    <div class="col" style="width: 50%;">
                        <h2 class="texto4" style="margin-bottom: 40px; margin-top: 5%; color: #274360;text-align: center; font-size: 42px; ">Cadastro de Quartos</h2>

                        <label style="margin-top: 10px!important; margin-right: 50%">Quarto</label>
                        <div class="form-group">
                            <input  style="width: 60%; margin-bottom: 25px;" type="text" maxlength="20" name="quarto" class="form-control">                                    
                        </div>

                        <label style="margin-top: 10%; margin-right: 52%; margin-bottom: 10%;">Tipo</label>
                        <select name="tipo" class="browser-default" style="width: 60%; margin-top: 5%; margin-bottom: 5%;">
                            <option disabled selected>Selecione o tipo de quarto</option>
                            <option>Simples</option>                                                                                       
                            <option>Luxo</option>                                    
                        </select>

                        <label style=" margin-right: 28%">Número de camas de solteiro</label>
                        <div class="form-group">
                            <input  style="width: 60%; margin-top: 10px; margin-bottom: 5%;" type="number"  min="0" id="number1" max="10" name="camaSolteiro" class="form-control" required>                                    
                        </div>
                        
                        <label style=" margin-right: 30%">Número de camas de casal</label>
                        <div class="form-group">
                            <input  style="width: 60%; margin-top: 10px; margin-bottom: 5%;" type="number"  min="0" id="number2" max="10" name="camaCasal" class="form-control" required>                                    
                        </div>

                        <label style=" margin-right: 42%">Valor da diária</label>
                        <div class="form-group">
                            <input  style="width: 60%; margin-top: 10px; margin-bottom: 8%;" type="number" min="50"id="number3" max="9999" name="diaria" class="form-control">                                    
                        </div>
 
                        <div class="bot">   
                            <input class="btn btn-primary" style="width: 60%;" type="submit" name="acao" value="Cadastrar"><br><br>
                            <a href="ListarQuarto">Voltar</a>
                             <br><br>   
                            <%
                                //Traz a mensagem diretamente da control
                                String msg = (String) request.getAttribute("msg");
                                if (msg != null) {

                            %>
                            <font color="#274360"><%=msg%></font>
                            <%}%> 
                            <br><br>                                   
                        </div>
                    </div>
                </form>
                <div class="col"><img src="view/img/fotosHotel/quarto.jpg" alt="Quarto" style="width: 500px;"></div>                      
            </center>
        </div> 

        <footer>
            <!-- rodapé -->
            <p style='font-size:18px; margin-top: 3vw; color: rgb(255,255,255,0.6)!important;'>&copy;2021 Breath Hotels Limitado</p>
        </footer> 
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
<%} else {
        response.sendRedirect("indexCliente");
    }%>