<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Checkout</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="view/styles/CadUser.css">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    </head>
    <body>       
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>
        <div class="signup-page">
            <div class="container">
                <div class="row">
                    <div class="col-sm-10 col-lg-6 offset-sm-1 offset-lg-3">        
                        <div class="form-bg">
                            <a href="#"><img src="view/img/icons/BreathLogo.png" alt="logo" class="logo"></a>
                            <h2>Checkout</h2>
                            <form action="CheckoutDados" method="GET">                                                                                       
                                <label>Selecione a reserva</label>
                                <select name="reserva" class="browser-default">
                                    <option disabled selected>Selecione a reserva</option>
                                    <c:forEach items="${user}" var="user">                                                                                                                       
                                        <option value="${user.id}">Reserva: ${user.id} | ${user.nome} | Quarto: ${user.quarto}</option>                                                                                       
                                    </c:forEach>                                    
                                </select>
                                <div class="form-group">                                    
                                    <%
                                        //Traz a mensagem diretamente da control
                                        String msg = (String) request.getAttribute("msg");
                                        if (msg != null) {

                                    %>
                                    <font color="#274360"><%=msg%></font>
                                    <%}%>                                    
                                    <div class="botoes">
                                        <input class="btn btn-primary" type="submit" name="acao" value="Pagamento Cartao"><br><br>
                                        <a href="index">Voltar</a>  
                                    </div>
                                </div>
                            </form>
                        </div>      
                    </div>
                </div>
            </div>
        </div>
        <%}%>  
    </body>
</html>