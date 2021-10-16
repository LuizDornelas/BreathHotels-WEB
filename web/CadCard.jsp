<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Cadastro de Cartão</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="view/styles/CadBedroom.css">
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
                            <h2>Cadastro de Cartão</h2>
                            <form action="CadastroCartao" method="POST">

                                <div class="form-group">
                                    <input type="text" name="numerocartao" class="form-control" placeholder="Número do cartão">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="nome" class="form-control" placeholder="Nome">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="validade" class="form-control" placeholder="Validade do cartão">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="codigo" class="form-control" placeholder="Código do cartão">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="bandeira" class="form-control" placeholder="Bandeira do cartão">
                                </div>              
                                <div class="form-group">
                                    <input class="btn btn-primary custom-btn" type="submit" name="acao" value="Cadastrar">
                                    </br></br>                                    
                                    <br>
                                    <%
                                        //Traz a mensagem diretamente da control
                                        String msg = (String) request.getAttribute("msg");
                                        if (msg != null) {

                                    %>
                                    <font color="#274360"><%=msg%></font>
                                    <%}%>
                                    <%}%>
                                    <div class="botoes">
                                        <a href="ListarCartao">Voltar</a>  
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