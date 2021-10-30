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
        <title>Lista de Cartões</title>
    </head>
    <body class="conteudo">   
        <div class="listando">
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>
        <center>   
            <h3 class="cyan-text text-cyan darken-2" style="margin-bottom: 40px;" >Cartões</h3>
            <table class="striped highlight" border="1">
                <input type="text" style="" id="search" class="form-control" placeholder="Busca cartão por usuário"/><br>  
                <tr>         
                    <th style="width: 10%;">Usuário</th>
                    <th style="width: 10%;">Número do cartão</th>
                    <th style="width: 10%;">Nome Cartão</th>
                    <th style="width: 5%;">Validade</th>
                    <th style="width: 5%;">Código</th>
                    <th style="width: 10%;">Bandeira</th>
                    <th style="width: 1%;">Editar</th>
                    <th style="width: 1%;">Excluir</th>
                </tr>
        </center>
        <c:forEach items="${todosCartao}" var="cartao">
            <tr>          
                <td id="user" align="center">${cartao.nome_cliente}</td>
                <td align="center">${cartao.numero}</td>
                <td align="center">${cartao.nome}</td>
                <td align="center">${cartao.validade}</td>
                <td align="center">${cartao.codigo}</td>
                <td align="center">${cartao.bandeira}</td>            
                <td align="center"><a href="IniciarEdicaoCartao?id=${cartao.id}" alt="">Editar</a></td>  
                <td align="center"><a href="ExcluirCartao?id=${cartao.id}" alt="">Excluir</a></td>  
            </tr>
        </c:forEach>
            </table>
        <%}%>
        <br><br>
        <a class="btn btn-outline-secondary" href="index">Voltar</a>  
        <a class="btn btn-outline-primary" href="CadCard">Cadastrar Cartao</a>        
        </div>
    </body>
</html>
<script>

$('#search').keyup(function() {
  var regex = new RegExp($('#search').val(), "i");
  var rows = $('table tr:gt(0)');
  rows.each(function (index) {
    title = $(this).children("#user").html()
    if (title.search(regex) != -1) {
      $(this).show();
    } else {
      $(this).hide();
    }
  });
});
</script>