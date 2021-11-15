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
        <style> 
            /* carousel */
            .slider .indicators .indicator-item.active {
                background-color: #274360;
            }
        </style>
    </head>
    <body id="conteudo1">
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
        %>
        <!-- Header --> 
        <nav style="background-color: #274360; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);">
            <div class="nav-wrapper">
                <a href="#!" alt="nome" style="font-size: 30px; margin-left: 30px;">Breath Hotels</a>
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
        <!-- Content -->
        <div class="container">
            <div class="row">
                <div class="col m4 s12">
                    <div class="icon-block">
                        <h2 class="center light-blue-text">
                            <i class="material-icons">room_service</i>  
                        </h2>
                        <h5 class="center">Missão</h5>
                        <p class="light">
                            Oferecer aos clientes um serviço de excelência, seja na hospedagem, alimentação e/ou gestão e organização de eventos, prezando pela qualidade, conforto e segurança, sempre com o intuito de fazer com que nossos clientes, sintam-se na extensão de suas casas.
                        </p>
                    </div>
                </div>
                <div class="col m4 s12">
                    <div class="icon-block">
                        <h2 class="center light-blue-text">
                            <i class="material-icons">visibility</i>  
                        </h2>
                        <h5 class="center">Visão</h5>
                        <p class="light">
                            Ser reconhecido como referência hoteleira e gastronômica, sempre com foco na rentabilidade, eficiência, preço justo e principalmente o comprometimento total com a satisfação de nossos clientes.
                        </p>
                    </div> 
                </div>
                <div class="col m4 s12">
                    <div class="icon-block">
                        <h2 class="center light-blue-text">
                            <i class="material-icons">star_border</i>  
                        </h2>
                        <h5 class="center">Valores</h5>
                        <p class="light">
                            Excelência, ética, comprometimento e responsabilidade socioambiental.
                        </p>
                    </div> 
                </div>
            </div>
        </div>
        <div class="parallax-container center valign-wrapper">
            <div class="parallax">
                <img src="view/img/fotosHotel/hotelPool.jpg">
            </div>       
        </div>                 

        <div class="container center-align">
            <div class="section">
                <div class="row">
                    <div class="col s12">
                        <h4 style="font-size:60px; color: #274360;">Breath Hotels</h4>
                        <p style="font-size:25px; color: #274360;">A sua casa longe de casa,</br> 
                            há mais de 30 anos!</p>
                    </div>      
                </div>
            </div>
        </div>


        <div class="parallax-container center valign-wrapper">          
            <div class="parallax">
                <img src="view/img/fotosHotel/hotelPool.jpg">
            </div>
        </div>

        <!-- Reservas -->
        <div style="background: #274360; padding: 50px;">
            <div class="list1">
                <center> 
                    <%//Traz a mensagem diretamente da control
                        List<Reserva> todasReservas = (List<Reserva>) request.getAttribute("todasReservas");
                        if (todasReservas.size() > 0) {%>
                    <h3 style="margin-bottom: 40px; color: #0277bd; text-align: center; font-size: 42px; ">Reservas em andamento</h3>             
                    <br>
                    <table class="striped highlight responsive-table" border="1">

                        <tr>               
                            <th style="width: 5%;">Reserva</th>
                            <th style="width: 15%;">Cliente</th>
                            <th style="width: 10%;">Entrada</th>
                            <th style="width: 5%;">Valor</th>
                            <th style="width: 5%;">Quarto</th>            
                        </tr>
                </center>

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
        </div>

        <!-- caroussel -->
        <div>
            <h3 style="margin-bottom: 50px; margin-top: 50px; color: #00CED1; text-align: center; font-size: 62px; ">Horários das atividades</h3> 
            <div class="slider">
                <ul class="slides">
                    <li>
                        <img src="view/img/fotosHotel/yoga.jpg">
                        <div class="caption center-align">
                            <h3>Yoga</h3>
                            <h5 class="light grey-text text-lighten-3">Sexta, sábado e domingo as 17h.</h5>
                        </div>
                    </li>
                    <li>
                        <img src="view/img/fotosHotel/golf.jpg"> 
                        <div class="caption center-align">
                            <h3>Aulas de Golf</h3>
                            <h5 class="light grey-text text-lighten-3">Quinta, sexta e sábado as 15h.</h5>
                        </div>
                    </li>
                    <li>
                        <img src="view/img/fotosHotel/hidro.jpg"> 
                        <div class="caption center-align">
                            <h3>Hidroginástica</h3>
                            <h5 class="light grey-text text-lighten-3">Sábado e domingo as 10h.</h5>
                        </div>
                    </li>
                    <li>
                        <img src="view/img/fotosHotel/aulaDanca.jpg"> 
                        <div class="caption center-align">
                            <h3>Aulas de Dança</h3>
                            <h5 class="light grey-text text-lighten-3">sexta e sábado as 18h. </h5>
                        </div>
                    </li>
                </ul>
            </div>
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
    const elemsDropdown = document.querySelectorAll(".dropdown-trigger");
    const instancesDropdown = M.Dropdown.init(elemsDropdown, {
        coverTrigger: false
    });


</script>
<script>
    $(document).ready(function () {
        $('.parallax').parallax();
    });

    //carousel
    $(document).ready(function () {
        $('.slider').slider({full_width: true});
    });
</script>
