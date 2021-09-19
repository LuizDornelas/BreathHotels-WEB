<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <title>Lista de Usuários</title>
    </head>
    <body>                    
<%
    //Valida se a sessão está valida
    Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
    } else {
%>

<a class="btn btn-outline-primary" href="CadUser.jsp">Cadastrar Usuários</a>
<br><br>

<center>                         
        <table border="1">
            <tr>                
                <th>Nome</th>
                <th>RG</th>
                <th>Telefone</th>
                <th>Rua</th>
                <th>Número</th>
                <th>Bairro</th>
                <th>Cidade</th>
                <th>Estado</th>
                <th>CEP</th>
                <th>Login</th>
                <th>Senha</th>
                <th>Tipo</th>
                <th>Ativo</th>
                <th>Editar</th>
                <th>Excluir</th>
            </tr>
    </center>

    <c:forEach items="${todosUsuarios}" var="user">
        <tr>            
            <td align="center">${user.nome}</td>
            <td align="center">${user.rg}</td>
            <td align="center">${user.telefone}</td>
            <td align="center">${user.rua}</td>
            <td align="center">${user.numero}</td>
            <td align="center">${user.bairro}</td>
            <td align="center">${user.cidade}</td>
            <td align="center">${user.estado}</td>
            <td align="center">${user.cep}</td>
            <td align="center">${user.login}</td>
            <td align="center">${user.senha}</td>
            <td align="center">${user.tipo.toString()}</td>
            <td align="center">${user.ativo.toString()}</td>
            <td align="center"><a href="EdicaoUsuario?id=${user.id}">Editar</a></td>
            <td align="center"><a href="ExcluirUsuario?id=${user.id}">Excluir</a></td>
        </tr>
    </c:forEach>
</table>

<%}%>
</form>
</body>
</html>
