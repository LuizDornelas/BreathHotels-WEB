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
        <title>Lista de Usuários</title>
    </head>
    <body class="conteudo"> 
        <div class="listandoUsers">
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>   
        <center> 
            <h3 class="cyan-text text-cyan darken-2">Usuários</h3>
            <table class="striped highlight responsive-table" border="1">
                <input type="text" style="" id="search" class="form-control" placeholder="Busca usuário"/><br>  
                <tr>                
                    <th style="width: 15%;">Nome</th>
                    <th style="width: 10%;">RG</th>
                    <th style="width: 10%;">Telefone</th>
                    <th style="width: 10%;">Rua</th>
                    <th style="width: 7px;">Número</th>
                    <th style="width: 10%;">Bairro</th>
                    <th style="width: 10%;">Cidade</th>
                    <th style="width: 10%;">Estado</th>
                    <th style="width: 10%;">CEP</th>
                    <th style="width: 7%;">Login</th>                
                    <th style="width: 10%;">Tipo</th>
                    <th style="width: 10%;">Ativo</th>
                    <th style="width: 10%;">Editar</th>
                    <th style="width: 10%;">Senha</th>
                </tr>
        </center>

        <c:forEach items="${todosUsuarios}" var="user">
            <tr>                                           
                <td id="nome" align="center">${user.nome}</td>
                <td align="center">${user.rg}</td>
                <td align="center">${user.telefone}</td>
                <td align="center">${user.rua}</td>
                <td align="center">${user.numero}</td>
                <td align="center">${user.bairro}</td>
                <td align="center">${user.cidade}</td>
                <td align="center">${user.estado}</td>
                <td align="center">${user.cep}</td>
                <td align="center">${user.login}</td>            
                <td align="center">${user.tipo.toString()}</td>
                <td align="center">${user.ativo.toString()}</td>
                <td align="center"><a href="IniciarEdicaoUsuario?id=${user.id}" alt="">Editar</a></td>    
                <td align="center"><a href="IniciarResetSenha?id=${user.id}" alt="">Resetar Senha</a></td>  
            </tr>
        </c:forEach>
            </table>
        <%}%>
        <br><br>
       <a class="btn btn-outline-secondary" href="index">Voltar</a>  
       <a class="btn btn-outline-primary" href="CadUser.jsp">Cadastrar Usuários</a>
        <br><br>
        </div>
    </body>
</html>
<script>

$('#search').keyup(function() {
  var regex = new RegExp($('#search').val(), "i");
  var rows = $('table tr:gt(0)');
  rows.each(function (index) {
    title = $(this).children("#nome").html()
    if (title.search(regex) != -1) {
      $(this).show();
    } else {
      $(this).hide();
    }
  });
});
</script>