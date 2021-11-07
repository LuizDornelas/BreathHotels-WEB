<%@page import="Modelo.Reserva"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <link rel="stylesheet" type="text/css" href="view/styles/index.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <title>Breath Hotels</title>
    </head>
    <body id="conteudo">
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
        %>
        <nav style="background-color: #274360; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); margin-bottom: 5vw; height: 100px;">
            <div class="nav-wrapper">
                <a href="#!" class="brand-logo"><img src="view/img/icons/BreathHotels-logo-white.png" alt="logo" style="width: 250px; margin: 10px;"></a>
                <ul class="right hide-on-med-and-down" style=" margin-top: 1.8vw; ">
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
                    <h2  class="text-light" style="font-size: 18px; color: rgb(255,255,255,0.6)!important; margin-top: 32%;">Olá, <%=login%></h2>
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

        <!-- Breath Hotels primeiro container --> 
        <br>

        <div class="row">
            <div class="col"><img src="view/img/fotosHotel/piscina1.jpeg" alt="piscina" style="width: 600px;"></div>
            <div class="col">
                <p class="texto1"><img src="view/img/icons/BreathLogo.png" alt="logo" style="width: 250px; height: 250px; "></p>
                <p class="texto1">A sua casa longe de casa,</br> 
                    há mais de 30 anos!</p>
            </div>          
        </div>

        <!-- Reservas -->
        <div class="reservas">

            <%//Traz a mensagem diretamente da control
                List<Reserva> todasReservas = (List<Reserva>) request.getAttribute("todasReservas");
                if (todasReservas.size() > 0) {%>
            <h3 class="res">Reservas em andamento</h3>             
            <br>
            <table class="table">
                <thead class="thead-light">
                    <tr>               
                        <th style="width: 5%;">Reserva</th>
                        <th style="width: 15%;">Cliente</th>
                        <th style="width: 10%;">Entrada</th>
                        <th style="width: 5%;">Valor</th>
                        <th style="width: 5%;">Quarto</th>            
                    </tr>
                </thead>


                <c:forEach items="${todasReservas}" var="todasReservas">      
                    <tr>                                       
                        <td>${todasReservas.numreserva}</td>
                        <td>${todasReservas.nomeCliente}</td>
                        <td>${todasReservas.entrada}</td>
                        <td>R$ ${todasReservas.valor}0</td>
                        <td>${todasReservas.quarto}</td>           
                    </tr>
                </c:forEach>   
            </table>
            <%} else {%>
            <h3>Não há reservas em andamento</h3>     
            <%}%>
        </div>



        <footer>
            <!-- rodapé -->
            <p style='font-size:18px; margin-top: 3vw; color: rgb(255,255,255,0.6)!important;'>&copy;2021 Breath Hotels Limitado</p>
        </footer>  
    </body>
</html>
<%} else {
        response.sendRedirect("indexCliente");
    }%>
    
    <script>
        const elemsDropdown = document.querySelectorAll(".dropdown-trigger");
        const instancesDropdown = M.Dropdown.init(elemsDropdown,{
            coverTrigger: false
        });
    </script>    