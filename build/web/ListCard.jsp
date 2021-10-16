<%-- 
    Document   : ListCard
    Created on : 15/10/2021, 18:03:50
    Author     : Leticia Possas
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <title>Lista de Itens</title>
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
        <h3 class="cyan-text text-cyan darken-2">Cartões</h3>
        <table class="striped highlight" border="1">
            <tr>                
                <th style="width: 10%;">Número do cartão</th>
                <th style="width: 10%;">Nome</th>
                <th style="width: 5%;">Validade</th>
                <th style="width: 5%;">Código</th>
                <th style="width: 10%;">Bandeira</th>
                <th style="width: 1%;">Editar</th>
                <th style="width: 1%;">Excluir</th>
            </tr>
    </center>

    <c:forEach items="${todosCartao}" var="cartao">
        <tr>            
            <td align="center">${cartao.numerocartao}</td>
            <td align="center">${cartao.nome}</td>
            <td align="center">${cartao.validade}</td>
            <td align="center">${cartao.codigo}</td>
            <td align="center">${cartao.bandeira}</td>
            <<td align="center"><a href="IniciarEdicaoCartao?id=${cartao.id}" alt="">Editar</a></td>     
            <td align="center"><a href="ExcluirCartao?id=${cartao.id}" alt="">Excluir</a></td>  
        </tr>
    </c:forEach>
</table>

<%}%>
<br><br>
<a class="btn btn-outline-secondary" href="index">Voltar</a>  
<a class="btn btn-outline-primary" href="CadCard.jsp">Cadastrar Cartao</a>        

</form>
</body>
</html>

