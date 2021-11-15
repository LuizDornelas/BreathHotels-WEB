<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Checkin</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico">
        <link rel="stylesheet" type="text/css" href="view/styles/index.css">        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">  
        <style>
            /* label focus color */
            .input-field input[type=datetime-local]:focus + label {
                color: #0277bd!important;
            }
            /* label underline focus color */
            .input-field input[type=datetime-local]:focus {
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
        <!-- checkin --> 
        <div class="row" style="width: 96%; background-color: #fff;
             border: 1px solid #e5e5e5;
             padding: 30px 30px 30px;
             margin: 30px!important;
             box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
             display: inline-block;">
            <center>
                <form action="CadastraCheckin" method="POST">   
                    <div class="col" style="width: 50%;">
                        <h2 style="margin-bottom: 40px; margin-top: 140px; color: #0277bd; text-align: center; font-size: 42px; ">Check-In</h2>

                        <div class="input-field" style="width: 70%;">
                            <input type="datetime-local" name="entrada" class="form-control timepicker">
                            <label class="active">Entrada</label>
                        </div>

                        <div class="input-field" style="width: 70%;">
                            <input type="datetime-local" name="saida" class="form-control timepicker">
                            <label class="active">Saída</label>
                        </div>

                        <div class="input-field">
                            <select name="cmb_quarto" class="browser-default" style="width: 70%;">
                                <option disabled selected>Selecione o quarto</option>                                                                                                                                            
                                <c:forEach items="${quarto}" var="quarto">                                                                                                                       
                                    <option value="${quarto.id}">${quarto.quarto} | R$${quarto.diaria} | Cama Solteiro: ${quarto.camaSolteiro} | Cama Casal: ${quarto.camaCasal}</option>                                                                                       
                                </c:forEach>                                                                                                                                                      
                            </select>    
                        </div>
                        <div class="input-field">
                            <select name="cmb_cliente" class="browser-default" style="width: 70%;">
                                <option disabled selected>Selecione o cliente</option>                                                                                                                                            
                                <c:forEach items="${user}" var="user">                                                                                                                       
                                    <option value="${user.id}">${user.nome}</option>                                                                                       
                                </c:forEach>                                                                                                                                                       
                            </select>    
                        </div>

                        <div class="bot">                                    
                            <%
                                //Traz a mensagem diretamente da control
                                String msg = (String) request.getAttribute("msg");
                                if (msg != null) {

                            %>
                            <font color="#274360"><%=msg%></font>
                            <%}%> 
                            <br><br> 

                            <input class="btn btn-primary" style="width: 70%; background: #0277bd;" type="submit" name="acao" value="Reservar"><br><br>
                            <a href="index">Voltar</a> 
                            </br>
                        </div>                    
                    </div>
                </form>
                <div class="col"><img src="view/img/fotosHotel/checkin.jpg" alt="Check-In" style="width: 40vw; margin-top: 30px; "></div>                      
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