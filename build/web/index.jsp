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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>             
        <title>Breath Hotels</title>
    </head>
    <body id="conteudo">
        <!-- navbar -->
        <nav class="navbar navbar-expand-sm  navbar-dark justify-content-around" style="background-color: #274360; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);">
            <!-- Brand/logo -->

            <nav class="navbar navbar-light bg-blackt">
                <a class="navbar-brand" href="#">                    
                    <h3>BreathHotels</h3>
                </a>    
            </nav>
                  <!-- Links -->
                  <ul class="navbar-nav" style="margin-left: 15vw;" >
                <li class="nav-item">
                    <a class="nav-link" href="ListarUsuario">Usuários</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ListarQuarto">Quartos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ListarCartao">Cartões</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Histórico</a>
                </li>

                <!-- Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                        Reservas
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="Checkin">Check-in</a>
                        <a class="dropdown-item" href="Checkout">Check-out</a>
                    </div>
                </li>
                <!-- Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                        Produtos
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="ListarItensDeCompra">Comprar itens</a>
                        <a class="dropdown-item" href="ListarItem">Estoque</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Relatorio">Relatório</a>
                </li>
            </ul>

            <ul class="navbar-nav ml-auto nav-flex-icons">

                <%
                    //Valida se a sessão está valida
                    Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
                    if (usuario == null) {
                        response.sendRedirect("login.jsp");
                    } else {
                        //Traz a mensagem diretamente da control
                        String login = usuario.getLogin();
                        if (login != null) {
                        }
                %>                             
                <h2  class="text-light" >Olá, <%=login%> </h2>
                <%}%>  

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                        <i class='fas fa-user-alt' style='font-size:24px;'></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-default"
                         aria-labelledby="navbarDropdownMenuLink-333">                        
                        <a class="dropdown-item" href="logout.jsp">Sair</a>
                    </div>
                </li>
            </ul>
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
            Boolean validaDados = (Boolean) request.getAttribute("validaDados");
            if (validaDados = true) {%>
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
        
       
    <div class="container">
        <h1 class="ativ">Horário das atividades do hotel</h1>  
        <div class="card" style="width:400px">
        <img class="card-img-top" src="view/img/fotosHotel/aulasDeGolf.jpg" alt="Card image" style="width:100%">
        <div class="card-body">
        <h4 class="card-title">Aulas de golf</h4>
        <p class="card-text">terça-feira das 10:00 as 12:00 horas</p>
        <p class="card-text">Sexta-feira das 13:00 as 15:00 horas</p>
        </div>
        </br>
  </div>  
  </div>
        </br></br>
        
        
         </br></br>
    <footer>
        <nav class="navbar navbar-expand-sm  navbar-dark bottom justify-content-center p-4" style="background-color: #274360;">
        <a class="navbar-brand" href="#">&copy;2021 Breath Hotels Limitado</a>
      </nav>
    </footer>
    </body>
</html>