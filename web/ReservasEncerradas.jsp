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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>             
        <title>Breath Hotels</title>
    </head>
    <body>  
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Cliente".equals(usuario.getTipo().toString())) {
        %>
    <center>
        <!-- Reservas -->
        <div class="reservas">

            <%//Traz a mensagem diretamente da control
                List<Reserva> todasReservas = (List<Reserva>) request.getAttribute("todasReservas");
                if (todasReservas.size() > 0) {%>
            <h3 class="res">Reservas Encerradas</h3>             
            <br>
            <table class="table">
                <input type="text" style="" id="search" class="form-control" placeholder="Busca por reserva"/><br>  
                <thead class="thead-light">
                    <tr>               
                        <th style="width: 5%;">Reserva</th>
                        <th style="width: 10%;">Funcionário</th>
                        <th style="width: 10%;">Entrada</th>
                        <th style="width: 10%;">Saída</th>
                        <th style="width: 5%;">Valor</th>
                        <th style="width: 5%;">Quarto</th>            
                    </tr>
                </thead>


                <c:forEach items="${todasReservas}" var="todasReservas">      
                    <tr>                                       
                        <td id="reserva">${todasReservas.numreserva}</td>
                        <td>${todasReservas.nomeFuncionario}</td>
                        <td>${todasReservas.entrada}</td>
                        <td>${todasReservas.saida}</td>
                        <td>R$ ${todasReservas.valor}0</td>
                        <td>${todasReservas.quarto}</td>           
                    </tr>
                </c:forEach>   
            </table>
            <%} else {%>
            <h3>Não há reservas em andamento</h3>     
            <%}%>
        </div>
        </br></br>
        <a href="indexCliente">Voltar</a>     
    </center>
</body>
</html>
<script>

    $('#search').keyup(function () {
        var regex = new RegExp($('#search').val(), "i");
        var rows = $('table tr:gt(0)');
        rows.each(function (index) {
            title = $(this).children("#reserva").html()
            if (title.search(regex) != -1) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
</script>
<%} else {
        response.sendRedirect("index");
    }%>