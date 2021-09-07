<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Breath Hotels</title>
    </head>
    <body>
        <%
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <form action="Login" method="POST">
            <h1>Logado com sucesso!</h1>
            <a href="logout.jsp">Sair</a>
        </form>
    </body>
</html>
