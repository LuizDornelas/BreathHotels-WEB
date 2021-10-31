<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Checkout - Dados</title>
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
            } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
        %>
        <div class="signup-page">            
            <div class="row">
                <div class="col-sm-10 col-lg-6 offset-sm-1 offset-lg-3">        
                    <div class="form-bg">
                        <form onsubmit='return confirmacao()' action="PagamentoCartao" method="POST"> 
                            <a href="#"><img src="view/img/icons/BreathLogo.png" alt="logo" class="logo"></a>
                            <h2>Dados Checkout</h2>                                                                                                                   
                            <div class="form-group">
                                <input type="hidden" name="reserva" class="form-control" value="${user.id}">
                                <div class="row">
                                    <label>Cliente</label>
                                    <input type="text" name="cliente" class="form-control" placeholder="Cliente" value="${user.nome}" readonly>
                                </div> 
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Entrada</label>
                                        <input type="text" name="entrada" class="form-control" placeholder="Entrada" value="${user.entrada}" readonly>
                                    </div>          
                                    <div class="col-md-6">
                                        <label>Saída</label>
                                        <input type="text" name="saida" class="form-control" placeholder="Saída" value="${user.saida}" readonly>
                                    </div>  
                                </div>       
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Quarto</label>
                                        <input type="text" name="quarto" class="form-control" placeholder="Quarto" value="${user.quarto}" readonly>
                                    </div>          
                                    <div class="col-md-6">
                                        <label>Total</label>
                                        <input type="text" name="total" class="form-control" placeholder="Total" value="R$${user.diaria}0" readonly>
                                    </div>                                   
                                </div>    
                                <div class="row">
                                    <label>Cartão</label>
                                    <input type="text" name="cartao" class="form-control" placeholder="Cartão" value="${cartao.numero}" readonly>
                                </div> 
                            </div>       

                            <h2>Consumo</h2>            

                            <table class="table">
                                <thead class="thead-light">
                                    <tr>               
                                        <th style="width: 15%;">Item</th>
                                        <th style="width: 15%;">Valor</th>
                                        <th style="width: 10%;">Quantidade</th>
                                        <th style="width: 5%;">Data</th>                                                
                                    </tr>
                                </thead>
                                </center>

                                <c:forEach items="${todosConsumos}" var="todosConsumos">      
                                    <tr>                                       
                                        <td>${todosConsumos.item}</td>
                                        <td>R$ ${todosConsumos.valor}0</td>
                                        <td>${todosConsumos.quantidade}</td>
                                        <td>${todosConsumos.data}</td>                                                
                                    </tr>
                                </c:forEach>   
                            </table>                           

                            <div class="form-group">                                    
                                <%
                                    //Traz a mensagem diretamente da control
                                    String msg = (String) request.getAttribute("msg");
                                    if (msg != null) {

                                %>
                                <font color="#274360"><%=msg%></font>
                                <%}%>                                                                    
                            </div>                        
                            <div class="botoes">
                                <input class="btn btn-primary" type="submit" name="acao" value="Confirmar Pagamento"><br><br>
                                <a href="Checkout">Voltar</a>  
                            </div>
                        </form>
                    </div>      
                </div>
            </div>            
        </div>        
    </body>
</html>
<script>
    function confirmacao() {
        alert("Transação aprovada com sucesso!");
    }
</script>
<%} else {
        response.sendRedirect("indexCliente.jsp");
    }%>