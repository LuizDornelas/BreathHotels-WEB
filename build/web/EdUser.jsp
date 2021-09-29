<%-- 
    Document   : EdUser
    Created on : 28/09/2021, 19:28:55
    Author     : Luiz Dornelas
--%>
<%@page import="Modelo.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Atualiza Usuários</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="view/styles/CadUser.css">
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
                            <h2>Atualização de Usuários</h2>
                            <form action="ConfirmarEdicao" method="POST">
                                
                                <div class="form-group">                                    
                                    <input type="hidden" name="txt_id" class="form-control" value="${usuario.id}">
                                </div>
                                <div class="form-group">
                                    <label>Nome:</label>
                                    <input type="text" name="txt_nome" class="form-control" value="${usuario.nome}">
                                </div>
                                <div class="form-group">
                                    <label>RG:</label>
                                    <input type="text" name="txt_rg" class="form-control" value="${usuario.rg}">
                                </div>
                                <div class="form-group">
                                    <label>Telefone:</label>
                                    <input type="tel" name="txt_telefone" class="form-control" value="${usuario.telefone}">
                                </div>
                                <div class="form-group">
                                    <label>Rua:</label>
                                    <input type="text" name="txt_rua" class="form-control" value="${usuario.rua}">
                                </div>
                                <div class="form-group">
                                    <label>Número:</label>
                                    <input type="text" name="txt_numero" class="form-control" value="${usuario.numero}">
                                </div>
                                <div class="form-group">
                                    <label>Bairro:</label>
                                    <input type="text" name="txt_bairro" class="form-control" value="${usuario.bairro}">
                                </div>
                                <div class="form-group">
                                    <label>Cidade:</label>
                                    <input type="text" name="txt_cidade" class="form-control" value="${usuario.cidade}">
                                </div>
                                <div class="form-group">
                                    <label>Estado:</label>
                                    <input type="text" name="txt_estado" class="form-control" value="${usuario.estado}">
                                </div>
                                <div class="form-group">
                                    <label>CEP:</label>
                                    <input type="text" name="txt_cep" class="form-control" value="${usuario.cep}">
                                </div>  
                                <div class="form-group">
                                    <label>Login</label>
                                    <input type="text" name="txt_login" class="form-control" value="${usuario.login}">
                                </div> 
                                <div class="form-group">
                                    <label>Senha:</label>
                                    <input type="password" name="txt_senha" class="form-control" value="${usuario.senha}">
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
                                Ativo:
                                <select name="cmb_ativo">                
                                    <option>SIM</option>
                                    <option>NAO</option>
                                </select>        
                                <input class="btn btn-primary custom-btn" type="submit" name="acao" value="Atualizar">
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