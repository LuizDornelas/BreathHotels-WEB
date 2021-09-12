<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Usuários</title>
    </head>
    <body>
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <h1>Cadastro de funcionários </h1>
        <form action="ControleUsuario" method="POST">
            Nome:<input type="text" name="txt_nome"><br><br>
            RG:<input type="text" name="txt_rg"><br><br>
            Telefone:<input type="tel" name="txt_telefone"><br><br>  
            Rua:<input type="text" name="txt_rua"><br><br>  
            Número:<input type="text" name="txt_numero"><br><br>  
            Bairro:<input type="text" name="txt_bairro"><br><br>  
            Cidade:<input type="text" name="txt_cidade"><br><br>  
            Estado:<input type="text" name="txt_estado"><br><br>  
            CEP:<input type="text" name="txt_cep"><br><br>  
            Login:<input type="text" name="txt_login"><br><br>  
            Senha:<input type="password" name="txt_senha"><br><br>  
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
            <input type="submit" value="Cadastrar" name="acao"/>     
            <a href="index.jsp">Voltar</a>     
            <br>
            <%
                //Traz a mensagem diretamente da control
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <font color="blue"><%=msg%></font>
            <%}%>
        </form>      
    </body>
</html>
