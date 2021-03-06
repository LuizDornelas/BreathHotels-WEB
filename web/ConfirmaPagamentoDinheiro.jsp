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
                        <form onsubmit='return confirmacao()' action="PagamentoDinheiro" method="POST"> 
                            <a href="#"><img src="view/img/fotosHotel/obrigada.jpg" alt="obrigada" class="logo" style="width: 100%; align-items: center;"></a>
                            <h2 style="margin-bottom: 40px; margin-top: 70px; color: #0277bd; text-align: center; font-size: 33px;">Dados Checkout</h2>                                                                                                                   
                            <div class="form-group">
                                <input type="hidden" name="reserva" class="form-control" value="${user.id}">
                                <div class="row">
                                    <label>Cliente</label>
                                    <input type="text" name="cliente" class="form-control" placeholder="Cliente" value="${user.nome}" readonly>
                                </div>                                      
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Quarto</label>
                                        <input type="text" name="quarto" class="form-control" placeholder="Quarto" value="${user.quarto}" readonly>
                                    </div>          
                                    <div class="col-md-6">
                                        <label>Total</label>
                                        <input type="text" name="total" class="form-control" placeholder="Total" value="${user.diaria}" readonly>
                                    </div>    
                                </div>    
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Valor pago</label>
                                        <input type="text" name="pago" class="form-control" placeholder="Total" value="R$${user.pago}0" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Troco</label>
                                        <input type="text" name="troco" class="form-control" placeholder="Troco" value="R$${user.troco}0" readonly>
                                    </div>
                                </div> 
                            </div>                                                       

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
                                <input class="btn btn-primary" style="background: #0277bd; color: white;" type="submit" name="acao" value="Confirmar Pagamento"><br><br>
                                <a href="javascript:history.back()">Voltar</a>
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
        alert("Pagamento realizado com sucesso!");
    }
</script>
<%} else {
        response.sendRedirect("indexCliente");
    }%>