<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <link rel="stylesheet" type="text/css" href="view/styles/cliente.css">        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <title>Lista de Itens</title>
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
            <h3 class="cyan-text text-cyan darken-2" style="margin-bottom: 40px;">Itens disponíveis</h3>
            <table class="striped highlight centered" border="1">
                <tr>                
                    <th style=" text-align: center;">Item</th>
                    <th style=" text-align: center;"">Valor</th>
                    <th style=" text-align: center;"">Quantidade</th>
                    
                    
                </tr>
        </center>

        <c:forEach items="${todosItens}" var="item">
            <tr>            
                <td align="center">${item.nome_item}</td>
                <td align="center">R$${item.valor_item}0</td>
                  <th style=" text-align: center;""><input type="number" min="0" id="number1" max="999" name="txt_quantidade" class="form-control"></th>
            </tr>
        </c:forEach>
            </table>
        <%}%>
        <br><br>
        <a class="btn btn-outline-secondary" href="indexCliente.jsp">Voltar</a>  
        <a class="btn btn-outline-primary" href="indexCliente.jsp">finalizar compra</a>        
    </div>
</body>
</html>

<script>
    // Select your input element.
   
    var number1 = document.getElementById('number1');

// Listen for input event on numInput.
    number1.onkeydown = function (e) {
        if (!((e.keyCode >= 16 && e.keyCode <= 17)
                || (e.keyCode >= 37 && e.keyCode <= 40)
                || (e.keyCode >= 48 && e.keyCode <= 57)
                || (e.keyCode === 8))) {
            return false;
        }
    }
</script>
