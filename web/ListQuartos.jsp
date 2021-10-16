<%@page import="Modelo.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" /> 
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <title>Lista de Quartos</title>
    </head>
    <body>                    
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>
         
    <center>       
        <h3 class="cyan-text text-cyan darken-2">Quartos</h3>
        <table class="striped highlight" border="1">
            <tr>                
                <th style="width: 10%;">Quarto</th>
                <th style="width: 10%;">Tipo</th>
                <th style="width: 5%;">Cama de Solteiro</th>
                <th style="width: 5%;">Cama de Casal</th>
                <th style="width: 10%;">Status</th>
                <th style="width: 5%;">Diária</th>
                <th style="width: 1%;">Editar</th>
                <th style="width: 1%;">Excluir</th>
            </tr>
    </center>

    <c:forEach  items="${todosQuartos}" var="quartos">
        <tr>            
            <td align="center">${quartos.quarto}</td>
            <td align="center">${quartos.tipo}</td>
            <td align="center">${quartos.camaSolteiro}</td>
            <td align="center">${quartos.camaCasal}</td>
            <td align="center">${quartos.status}</td>
            <td align="center">R$${quartos.diaria}0</td>
            <td align="center"><a href="IniciarEdicaoQuarto?id=${quartos.id}" alt="">Editar</a></td>     
            <td align="center"><a href="ExcluirQuarto?id=${quartos.id}" alt="">Excluir</a></td>  
        </tr>
    </c:forEach>
</table>

<%}%>

<br><br>
 <a class="btn btn-outline-secondary" href="index">Voltar</a>  
 <a class="btn btn-outline-primary" href="CadBedroom.jsp">Cadastrar Quartos</a>        
</form
</body>
</html>