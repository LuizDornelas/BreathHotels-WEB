<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
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
        <title>Lista de Reservas</title>
    </head>
    <body id="conteudo"> 
        <div class="listandoUsers">
            <%
                //Valida se a sessão está valida
                Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
                if (usuario == null) {
                    response.sendRedirect("login.jsp");
                } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
            %>   
            <center> 
                <h3 class="cyan-text text-cyan darken-2">Reservas Encerradas</h3>
                <table class="striped highlight responsive-table" border="1">
                    <input type="text" style="" id="search" class="form-control" placeholder="Busca por reserva"/><br>  
                    <tr>                
                        <th style="width: 5%;">Reserva</th>
                        <th style="width: 10%;">Quarto</th>
                        <th style="width: 10%;">Cliente</th>
                        <th style="width: 10%;">Entrada</th>
                        <th style="width: 10%;">Saída</th>
                        <th style="width: 10%;">Valor</th>
                        <th style="width: 10%;">Funcionário</th>              
                    </tr>
            </center>

            <c:forEach items="${todasReservas}" var="reserva">
                <tr>                                           
                    <td id="reserva" align="center">${reserva.reserva}</td>
                    <td align="center">${reserva.quarto}</td>
                    <td align="center">${reserva.nome}</td>
                    <td align="center">${reserva.entrada}</td>
                    <td align="center">${reserva.saida}</td>
                    <td align="center">R$${reserva.valor}0</td>
                    <td align="center">${reserva.funcionario}</td>                
                </tr>
            </c:forEach>
        </table>        
        <br><br>
        <a class="btn btn-outline-secondary" href="index">Voltar</a>        
        <br><br>
    </div>
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
        response.sendRedirect("indexCliente");
    }%>