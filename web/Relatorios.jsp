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
        <title>Relatório</title>
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
                <h3 class="cyan-text text-cyan darken-2">Relatório de reservas</h3>        
                <table class="striped highlight" border="1">
                    <thead class="thead-light">
                        <tr>               
                            <th style="width: 33%;">Mês</th>
                            <th class="col s6 ml-5" style="width: 33%">Quantidade de reservas</th>
                            <th style="width: 10%;">Total de ganhos</th>                     
                        </tr>
                    </thead>
            </center>

            <c:forEach items="${reservaMes}" var="reserva">      
                <tr>                                       
                    <td>${reserva.mes}</td>
                    <td style="width: 33%;">${reserva.quantidade}</td>
                    <td>${reserva.total}</td>                  
                </tr>
            </c:forEach>   
        </table>  
        <br><br>
        <a class="btn btn-outline-secondary" href="index">Voltar</a>  
    </center>

</div>
</body>
</html>
<%} else{
response.sendRedirect("indexCliente.jsp");
}%>