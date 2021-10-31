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
                            <h2>Atualização de Usuários</h2>
                            <form action="ConfirmarEdicao" method="POST">

                                <div class="form-group">                                    
                                    <input type="hidden" name="txt_id" class="form-control" value="${usuario.id}">
                                </div>
                                <div class="form-group">
                                    <label>Nome:</label>
                                    <input type="text" name="txt_nome" maxlength="80" class="form-control" value="${usuario.nome}">
                                </div>
                                <div class="form-group">
                                    <label>RG:</label>
                                    <input type="text" name="txt_rg" maxlength="13" OnKeyPress="formatar('##.###.###-##', this)" class="form-control" value="${usuario.rg}">
                                </div>
                                <div class="form-group">
                                    <label>Telefone:</label>
                                    <input type="input" name="txt_telefone" onkeydown="phoneMask()" maxlength="15" class="form-control" value="${usuario.telefone}">                             
                                </div>
                                <div class="form-group">
                                    <label>Rua:</label>
                                    <input type="text" name="txt_rua" maxlength="40" class="form-control" value="${usuario.rua}">
                                </div>
                                <div class="form-group">
                                    <label>Número:</label>
                                    <input type="number" min="0" id="number" max="9999" name="txt_numero" class="form-control" value="${usuario.numero}">
                                </div>
                                <div class="form-group">
                                    <label>Bairro:</label>
                                    <input type="text" name="txt_bairro" maxlength="40" class="form-control" value="${usuario.bairro}">
                                </div>
                                <div class="form-group">
                                    <label>Cidade:</label>
                                    <input type="text" name="txt_cidade" maxlength="40" class="form-control" value="${usuario.cidade}">
                                </div>
                                <div class="form-group">
                                    <label>Estado:</label>
                                    <input type="text" name="txt_estado" maxlength="40" class="form-control" value="${usuario.estado}">
                                </div>
                                <div class="form-group">
                                    <label>CEP:</label>
                                    <input type="text" name="txt_cep" maxlength="9" OnKeyPress="formatar('#####-###', this)" class="form-control" value="${usuario.cep}">
                                </div>  
                                <div class="form-group">
                                    <label>Login</label>
                                    <input type="text" name="txt_login" maxlength="20" class="form-control" value="${usuario.login}">
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
                                <div class="botoes">
                                    <a href="ListarUsuario">Voltar</a>  
                                </div>
                            </form>
                        </div>      
                    </div>
                </div>
            </div>
        </div>
        <script>
            function formatar(mascara, documento) {
                var i = documento.value.length;
                var saida = mascara.substring(0, 1);
                var texto = mascara.substring(i)

                if (texto.substring(0, 1) != saida) {
                    documento.value += texto.substring(0, 1);
                }

            }
        </script>
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
        </script>
        <script>
                function phoneMask() {
                    var key = window.event.key;
                    var element = window.event.target;
                    var isAllowed = /\d|Backspace|Tab/;
                    if (!isAllowed.test(key))
                        window.event.preventDefault();
                    var inputValue = element.value;
                    inputValue = inputValue.replace(/\D/g, '');
                    inputValue = inputValue.replace(/(^\d{2})(\d)/, '($1) $2');
                    inputValue = inputValue.replace(/(\d{4,5})(\d{4}$)/, '$1-$2');
                    element.value = inputValue;
                }
        </script>
        <%} else {
                response.sendRedirect("indexCliente.jsp");
            }%>