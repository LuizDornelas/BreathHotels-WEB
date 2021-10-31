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
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <title>Lista de Quartos</title>
    </head>
    <body class="conteudo"> 
        <div class="listando">
            <%
                //Valida se a sessão está valida
                Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
                if (usuario == null) {
                    response.sendRedirect("login.jsp");
                } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
            %>       
            <center>       
                <h3 class="cyan-text text-cyan darken-2" style="margin-bottom: 40px;">Quartos</h3>
                <table class="striped highlight" border="1">
                    <input type="text" style="" id="search" class="form-control" placeholder="Busca quarto"/><br>  
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
                    <td id="quarto" align="center">${quartos.quarto}</td>
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
        <br><br>
        <a class="btn btn-outline-secondary" href="index">Voltar</a>  
        <a class="btn btn-outline-primary" href="CadBedroom.jsp">Cadastrar Quartos</a> 
    </div>
</body>
</html>
<script>

    $('#search').keyup(function () {
        var regex = new RegExp($('#search').val(), "i");
        var rows = $('table tr:gt(0)');
        rows.each(function (index) {
            title = $(this).children("#quarto").html()
            if (title.search(regex) != -1) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
</script>
<%} else {
        response.sendRedirect("indexCliente.jsp");
    }%>