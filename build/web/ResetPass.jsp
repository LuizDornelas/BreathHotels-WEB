<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Atualiza Usuários</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="view/styles/CadUser.css">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="signup-page">
            <div class="container">
                <%
                    //Valida se a sessão está valida
                    Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
                    if (usuario == null) {
                        response.sendRedirect("login.jsp");
                    } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
                %>     
                <div class="row">
                    <div class="col-sm-10 col-lg-6 offset-sm-1 offset-lg-3">        
                        <div class="form-bg">
                            <a href="#"><img src="view/img/icons/BreathLogo.png" alt="logo" class="logo"></a>
                            <h2>Resetar Senha</h2>
                            <form action="ResetSenha" method="POST">

                                <div class="form-group">                                    
                                    <input type="hidden" name="txt_id" class="form-control" value="${usuario.id}">
                                </div>
                                <div class="form-group">
                                    <label>Nova Senha:</label>
                                    <input type="password" name="txt_senha" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Confirmar Senha:</label>
                                    <input type="password" name="txt_confirma" class="form-control" required>
                                </div>                                    
                                <input class="btn btn-primary custom-btn" type="submit" name="acao" value="Resetar Senha">
                                <%
                                    //Traz a mensagem diretamente da control
                                    String msg = (String) request.getAttribute("msg");
                                    if (msg != null) {

                                %>
                                <font color="#274360"><%=msg%></font>
                                <%}%>                                
                                <div class="botoes">
                                    <a href="ListarUsuario">Voltar</a>  
                                </div>
                            </form>
                        </div>      
                    </div>
                </div>
            </div>
        </div>
        <%} else {
                response.sendRedirect("indexCliente");
            }%>