<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Comprar itens</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico">
        <link rel="stylesheet" type="text/css" href="view/styles/Estoque.css">        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    </head>
    <body class="conteudo">     
        <div class="row"  style="width: 95%;">
            <%
                //Valida se a sessão está valida
                Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
                if (usuario == null) {
                    response.sendRedirect("login.jsp");
                } else {
            %>     
        </div>
        <div class="row" style="width: 95%;">
            <center>
                <form action="ComprarItens" method="POST">   
                    <div class="col" style="width: 50%;">
                        <h2 class="texto4" style="margin-bottom: 40px; margin-top: 100px; color: #274360;text-align: center; font-size: 42px; ">Produtos</h2>

                        <label style="margin-top: 10%; margin-right: 50%; margin-bottom: 10%;">Quarto</label>
                        <select name="quarto" class="browser-default" style="width: 60%; margin-top: 10px; margin-bottom: 10px;">
                            <option disabled selected>Selecione o quarto</option>
                            <c:forEach items="${quarto}" var="quarto">                                                                                                                       
                                <option value="${quarto.id}">${quarto.quarto} | Cama Solteiro: ${quarto.camaSolteiro} | Cama Casal: ${quarto.camaCasal}</option>                                                                                       
                            </c:forEach>                                    
                        </select>

                        <label style="margin-right: 50%;">Produto</label>
                        <select name="item" class="browser-default" style="width: 60%; margin-top: 10px; margin-bottom: 10px;">
                            <option disabled selected>Selecione o produto</option>
                            <c:forEach items="${todosItens}" var="item">                                                                                                                     
                                <option  <option value="${item.id}">${item.nome_item} | Valor: ${item.valor_item} | Quantidade: ${item.quantidade}</option>                                                                                      
                            </c:forEach>                                    
                        </select>

                        <label style="margin-top: 10px!important; margin-right: 46%">Quantidade</label>
                        <div class="form-group">
                            <input  style="width: 60%; margin-top: 10px;" type="number" min="0" id="number" max="999" name="quantidade" class="form-control" required>                                    
                        </div>

                        <div class="bot">                                    
                            <%
                                //Traz a mensagem diretamente da control
                                String msg = (String) request.getAttribute("msg");
                                if (msg != null) {

                            %>
                            <font color="#274360"><%=msg%></font>
                            <%}%> 
                            <br><br> 

                            <input class="btn btn-primary" style="width: 60%;" type="submit" name="acao" value="Comprar"><br><br>
                            <a href="index">Voltar</a>                                     
                        </div>
                    </div>
                </form>
                <div class="col"><img src="view/img/fotosHotel/coffee.jpg" alt="piscina" style="width: 500px;"></div>                      
            </center>
        </div>               
    </body>
    <%}%>
</html>

<script>
    // Select your input element.
    var number = document.getElementById('number');


// Listen for input event on numInput.
    number.onkeydown = function (e) {
        if (!((e.keyCode === 190)
                || (e.keyCode >= 16 && e.keyCode <= 17)
                || (e.keyCode >= 37 && e.keyCode <= 40)
                || (e.keyCode >= 48 && e.keyCode <= 57)
                || (e.keyCode === 8))) {
            return false;
        }
    }
</script>
