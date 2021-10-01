<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Cadastro de Itens</title>
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
                            <h2>Cadastro de Itens</h2>
                            <form action="CadastroItem" method="POST">

                                <div class="form-group">
                                    <input type="text" name="txt_item" maxlength="25" class="form-control" required placeholder="Item">
                                </div>
                                <div class="form-group">
                                    <input type="number" min="0" id="number" max="9999" step="0.01" name="txt_valor_item" class="form-control" required placeholder="Valor">
                                </div>
                                <div class="form-group">
                                    <input type="number" min="0" id="number2" max="9999" step="0.01" name="txt_valor_compra" class="form-control" required placeholder="Valor fornecedor">                                      
                                </div>
                                <div class="form-group">
                                    <input type="number" min="0" id="number3" max="999" name="txt_quantidade" class="form-control" required placeholder="Quantidade">                                    
                                </div>
                                <div class="form-group">
                                    <input type="text" name="txt_nome_fornecedor" maxlength="25" class="form-control" required placeholder="Fornecedor">    
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
                                        <a href="index.jsp">Voltar</a>  
                                    </div>
                            </form>
                        </div>      
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<script>
    // Select your input element.
    var number = document.getElementById('number');
    var number2 = document.getElementById('number2');
    var number3 = document.getElementById('number3');

// Listen for input event on numInput.
    number.onkeydown = function (e) {
        if (!((e.keyCode === 190)
                || (e.keyCode >= 16 && e.keyCode <= 17)
                || (e.keyCode >= 37 && e.keyCode <= 40)
                || (e.keyCode >= 48 && e.keyCode <= 57)
                || (e.keyCode === 8))) {
            return false;
        }
    }
    number2.onkeydown = function (e) {
        if (!((e.keyCode === 190)
                || (e.keyCode >= 16 && e.keyCode <= 17)
                || (e.keyCode >= 37 && e.keyCode <= 40)
                || (e.keyCode >= 48 && e.keyCode <= 57)
                || (e.keyCode === 8))) {
            return false;
        }
    }
    number3.onkeydown = function (e) {
        if (!((e.keyCode >= 16 && e.keyCode <= 17)
                || (e.keyCode >= 37 && e.keyCode <= 40)
                || (e.keyCode >= 48 && e.keyCode <= 57)
                || (e.keyCode === 8))) {
            return false;
        }
    }
</script>