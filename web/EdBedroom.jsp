<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Editar quartos</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="view/styles/CadUser.css">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico">
        <link rel="stylesheet" type="text/css" href="view/styles/index.css">        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">  
        <style>
            /* label focus color */
            .input-field input[type=text]:focus + label {
                color: #0277bd!important;
            }
            /* label underline focus color */
            .input-field input[type=text]:focus {
                border-bottom: 1px solid  #0277bd!important;
                box-shadow: 0 1px 0 0 #0277bd!important;
            }
            /* label focus color */
            .input-field input[type=number]:focus + label {
                color: #0277bd!important;
            }
            /* label underline focus color */
            .input-field input[type=number]:focus {
                border-bottom: 1px solid  #0277bd!important;
                box-shadow: 0 1px 0 0 #0277bd!important;
            }
        </style>
    </head>
    <body id="conteudo">
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
        %>  
        <!-- header --> 
        <div class="navbar-fixed" style=" margin-bottom: 5vw;">
            <nav style="background-color: #274360; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);">
                <div class="nav-wrapper">
                    <a href="index" alt="nome" style="font-size: 30px; margin-left: 30px;">Breath Hotels</a>
                    <ul class="right hide-on-med-and-down">
                        <li><a href="ListarUsuario" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Usuários</a></li>
                        <li><a href="ListarQuarto" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Quartos</a></li>
                        <li><a href="ListarCartao" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Cartões</a></li>
                        <li><a href="Relatorio" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Relatório</a></li>
                        <!-- Dropdown Trigger -->
                        <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;" href="#!" data-target="dropdown1">Histórico<i class="material-icons right">arrow_drop_down</i></a></li>
                        <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;" href="#!" data-target="dropdown2">Reservas<i class="material-icons right">arrow_drop_down</i></a></li>
                        <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;" href="#!" data-target="dropdown3">Produtos<i class="material-icons right">arrow_drop_down</i></a></li>
                        <ul class="left hide-on-med-and-down">
                            <%
                                //Traz a mensagem diretamente da control
                                String login = usuario.getLogin();
                                if (login != null) {
                                }
                            %> 
                           <li><a href="#" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Olá, <%=login%></a><li>
                        </ul>
                        <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important; margin-right: 1vw;"  href="#!" data-target="dropdown4"><i class="material-icons right" style="font-size: 30px; margin-bottom: 20%;">account_circle</i></a>
                    </ul>

                    <ul id="dropdown1" class="dropdown-content">
                        <li><a href="ReservasEncerradas" style="font-size: 18px; color: #274360;">Reservas</a></li>
                        <li><a href="Consumos" style="font-size: 18px; color: #274360;">Consumos</a></li>
                        <li class="divider"></li>
                    </ul>
                    <ul id="dropdown2" class="dropdown-content">
                        <li><a href="Checkin" style="font-size: 18px; color: #274360;">Check-in</a></li>
                        <li><a href="Checkout" style="font-size: 18px; color: #274360;">Check-out</a></li>
                        <li class="divider"></li>
                    </ul>
                    <ul id="dropdown3" class="dropdown-content">
                        <li><a  href="ListarItensDeCompra" style="font-size: 18px; color: #274360;">Comprar itens</a></li>
                        <li><a href="ListarItem" style="font-size: 18px; color: #274360;">Estoque</a></li>
                        <li class="divider"></li>
                    </ul>
                    <ul id="dropdown4" class="dropdown-content">  
                        <li><a href="logout.jsp" style="font-size: 18px; color: #274360;">Sair</a></li>
                    </ul>        

                </div>
            </nav>
        </div>
        <!-- editar -->
        <div class="row" style="width: 96%; background-color: #fff;
             border: 1px solid #e5e5e5;
             padding: 30px 30px 30px;
             margin: 30px!important;
             box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
             display: inline-block;">
            <center>
                <form action="ConfirmarEdicaoQuarto" method="POST">   
                    <div class="col" style="width: 50%;">
                        <h2 style="margin-bottom: 40px; margin-top: 55px; color: #0277bd; text-align: center; font-size: 42px; ">Atualizar quartos</h2>

                        <div  class="input-field">                                    
                            <input type="hidden" name="id" class="form-control" value="${quarto.id}">
                        </div>

                        <div class="input-field" style="width: 70%;">
                            <input type="text" maxlength="20" name="quarto" class="form-control"  value="${quarto.quarto}">  
                            <label class="active">Quarto</label>
                        </div>


                        <select name="tipo" class="browser-default" style="width: 70%; margin-top: 5%; margin-bottom: 5%;" required>
                            <option disabled selected>Selecione o tipo de quarto</option>
                            <option>Simples</option>                                                                                       
                            <option>Luxo</option>                                    
                        </select>

                        <div  class="input-field" style="width: 70%;">
                            <input   type="number"  min="0" id="number1" max="10" name="camaSolteiro" class="form-control" value="${quarto.camaSolteiro}"> 
                            <label class="active">Número de camas de solteiro</label>
                        </div>

                        <div  class="input-field" style="width: 70%;">
                            <input type="number"  min="0" id="number2" max="10" name="camaCasal" class="form-control" value="${quarto.camaCasal}">
                            <label class="active">Número de camas de casal</label>
                        </div>

                        <div class="input-field" style="width: 70%;">
                            <input  type="number" min="50"id="number3" max="9999" name="diaria" class="form-control" value="${quarto.diaria}">   
                            <label class="active">Valor da diária</label>
                        </div>
                        <br>
                        <div class="bot">   
                            <input class="btn btn-primary" style="width: 70%;  background: #0277bd;" type="submit" name="acao" value="Atualizar"><br><br>
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
                <div class="col"><img src="view/img/fotosHotel/room2.jpg" alt="Quarto" style="width: 550px;"></div>                      
            </center>
        </div> 
        <!-- rodapé -->
        <footer class="page-footer" style=" background-color: #274360; text-align: center;">
            <div class="row" style=" text-align: center;">
                <div class="col s12 ">
                    <h5 style="font-size:18px; margin-top: 2vw; color: rgb(255,255,255,0.6)!important; ">&copy;2021 Breath Hotels Limitado</h5>
                </div>
            </div>
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

<script>
    // NavBar
    const elemsDropdown = document.querySelectorAll(".dropdown-trigger");
    const instancesDropdown = M.Dropdown.init(elemsDropdown, {
        coverTrigger: false
    });
</script>