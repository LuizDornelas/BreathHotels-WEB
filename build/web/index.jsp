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
    <body>

        <!-- navbar -->
        <nav class="navbar navbar-expand-sm  navbar-dark" style="background-color: #274360;">
            <!-- Brand/logo -->

            <nav class="navbar navbar-light bg-blackt">
                <a class="navbar-brand" href="#">                    
                    <h3>BreathHotels</h3>
                </a>
            </nav>

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
                <h3  class="text-light" >Olá, <%=login%> </h3>
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

        <!-- Segunda navbar -->
        <nav class="navbar navbar-expand-sm navbar-dark justify-content-between" style="background-color: #4682B4;">

            <!-- Links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="ListarUsuario">Usuários</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ListarItem">Itens</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ListarQuarto">Quartos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Cartões</a>
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
                        <a class="dropdown-item" href="#">Check-out</a>
                    </div>
                </li>
                <!-- Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                        Produtos
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="ComprarItens.jsp">Comprar itens</a>
                        <a class="dropdown-item" href="Estoque.jsp">Estoque</a>
                    </div>
                </li>
            </ul>
        </nav>
        <br>
    <center> 
        <%//Traz a mensagem diretamente da control
            Boolean validaDados = (Boolean) request.getAttribute("validaDados");
            if (validaDados = true) {%>
        <h3>Reservas em andamento</h3>             

        <table class="table">
            <thead class="thead-light">
                <tr>                                
                    <th style="width: 15%;">Cliente</th>
                    <th style="width: 10%;">Entrada</th>
                    <th style="width: 5%;">Valor</th>
                    <th style="width: 5%;">Quarto</th>            
                </tr>
            </thead>
    </center>

    <c:forEach items="${todasReservas}" var="todasReservas">      
        <tr>                                           
            <td>${todasReservas.nomeCliente}</td>
            <td>${todasReservas.entrada}</td>
            <td>${todasReservas.valor}</td>
            <td>${todasReservas.quarto}</td>           
        </tr>
    </c:forEach>   
</table>
<%} else {%>
<h3>Não há reservas em andamento</h3>     
<%}%>

</body>
</html>