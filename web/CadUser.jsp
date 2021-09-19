<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <title>Cadastro de Usuários</title>
    </head>
    <body>                
    <center>                                 
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>        
        <h1>Cadastro de funcionários </h1>
        <form action="CadastroUsuario" method="POST">
            Nome:<input type="text" name="txt_nome" required><br><br>
            RG:<input type="text" name="txt_rg" required><br><br>
            Telefone:<input type="tel" name="txt_telefone" required><br><br>  
            Rua:<input type="text" name="txt_rua" required><br><br>  
            Número:<input type="text" name="txt_numero" required><br><br>  
            Bairro:<input type="text" name="txt_bairro" required><br><br>  
            Cidade:<input type="text" name="txt_cidade" required><br><br>  
            Estado:<input type="text" name="txt_estado" required><br><br>  
            CEP:<input type="text" name="txt_cep" required><br><br>  
            Login:<input type="text" name="txt_login" required><br><br>  
            Senha:<input type="password" name="txt_senha" required><br><br>             
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
            <a href="ListarUsuario">Voltar</a>                
            <input class="btn btn-primary" type="submit" name="acao" value="Cadastrar">
            <br>
            <%

                //Traz a mensagem diretamente da control
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {

            %>
            <font color="blue"><%=msg%></font>
            <%}%>
            <%}%>
        </form>
    </body>
</html>
