<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Cadastro de Usuários</title>
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
                    } else {
                %>     
                <div class="row">
                    <div class="col-sm-10 col-lg-6 offset-sm-1 offset-lg-3">        
                        <div class="form-bg">
                            <a href="#"><img src="view/img/icons/BreathLogo.png" alt="logo" class="logo"></a>
                            <h2>Cadastro de Usuários</h2>
                            <form action="CadastroUsuario" method="POST">

                                <div class="form-group">
                                    <input type="text" name="txt_nome" class="form-control" required placeholder="Nome">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="txt_rg" class="form-control" required placeholder="Documento de identidade">
                                </div>
                                <div class="form-group">
                                    <input type="tel" name="txt_telefone" class="form-control" required placeholder="Telefone">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="txt_rua" class="form-control" required placeholder="Rua">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="txt_numero" class="form-control" required placeholder="Número">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="txt_bairro" class="form-control" required placeholder="Bairro">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="txt_cidade" class="form-control" required placeholder="Cidade">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="txt_estado" class="form-control" required placeholder="Estado">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="txt_cep" class="form-control" required placeholder="CEP">
                                </div>  
                                <div class="form-group">
                                    <input type="text" name="txt_login" class="form-control" required placeholder="Login">
                                </div> 
                                <div class="form-group">
                                    <input type="password" name="txt_senha" class="form-control" required placeholder="Senha">
                                </div> 
                                Tipo:           
                                <%
                                    //Valida se é Func ou Admin, conforme login terá tipos diferentes de usuário para cadastrar
                                    if ("Admin".equals(usuario.getTipo().toString())) {
                                %>
                                <select name="cmb_tipo">
                                    <option>Admin</option>
                                    <option>Func</option>
                                    <option>Cliente</option>
                                </select>            
                                <%} else {%>          
                                <select name="cmb_tipo">                
                                    <option>Func</option>
                                    <option>Cliente</option>
                                </select>
                                <%}%>
                                <br><br>         
                                <input class="btn btn-primary custom-btn" type="submit" name="acao" value="Cadastrar">
                                <%

                                    //Traz a mensagem diretamente da control
                                    String msg = (String) request.getAttribute("msg");
                                    if (msg != null) {

                                %>
                                <font color="#274360"><%=msg%></font>
                                <%}%>
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
    </body>
</html>