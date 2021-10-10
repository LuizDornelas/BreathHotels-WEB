<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Editar quartos</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="view/styles/CadUser.css">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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
                            <h2>Editar Quartos</h2>
                            <form action="ConfirmarEdicaoQuarto" method="POST">

                                <div class="form-group">
                                    <input type="text" name="quarto" class="form-control" placeholder="Quarto" value="${quartos.quarto}">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="tipo" class="form-control" placeholder="Tipo" value="${quartos.tipo}">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="camaSolteiro" class="form-control" placeholder="Número de camas de solteiro" value="${quartos.camaSolteiro}">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="camaCasal" class="form-control" placeholder="Número de camas de casal" value="${quartos.camaCasal}">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="diaria" class="form-control" placeholder="Valor da diária" value="${quartos.diaria}">
                                </div>              
                                 <div class="form-group">
                                    <input class="btn btn-primary custom-btn" type="submit" name="acao" value="Cadastrar" >
                                    <%
                                        //Traz a mensagem diretamente da control
                                        String msg = (String) request.getAttribute("msg");
                                        if (msg != null) {

                                    %>
                                    <font color="#274360"><%=msg%></font>
                                    <%}%>
                                    <%}%>
                                    <div class="botoes">
                                        <a href="ListarQuarto">Voltar</a>  
                                    </div>
                                </div>
                            </form>
                        </div>      
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>