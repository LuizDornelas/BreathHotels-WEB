<%@page import="Modelo.Reserva"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Comprar itens</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <link rel="stylesheet" type="text/css" href="view/styles/index.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <style>        
            /* label focus color */
            .input-field input[type=number]:focus + label {
                color: #0277bd!important;
            }
            /* label underline focus color */
            .input-field input[type=number]:focus {
                border-bottom: 1px solid  #0277bd!important;
                box-shadow: 0 1px 0 0 #0277bd!important;
            }      
        </style>    
    </head>
    <body id="conteudo">
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Cliente".equals(usuario.getTipo().toString())) {
                //Traz a mensagem diretamente da control
                String login = usuario.getLogin();
                if (login != null) {
                }
        %>   
        <!-- navbar -->
        <div class="navbar-fixed" style=" margin-bottom: 5vw;">
            <nav style="background-color: #274360; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);">
                <div class="nav-wrapper">
                    <a href="indexCliente" alt="nome" style="font-size: 30px; margin-left: 30px;">Breath Hotels</a>  
                    <ul class="right hide-on-med-and-down">  
                        <li><a href="ItensDeCompra" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Comprar itens</a></li>  
                        <li><a href="Encerradas" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Reservas encerradas</a></li>  
                        <li><a href="Consumo" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Histórico de consumo</a></li>
                        <li><a href="#" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Olá, <%=login%></a><li>
                        <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important; margin-right: 1vw;"  href="#!" data-target="dropdown4"><i class="material-icons right" style="font-size: 30px; margin-bottom: 20%;">account_circle</i></a>
                    </ul>
                    <ul id="dropdown4" class="dropdown-content">  
                        <li><a href="logout.jsp" style="font-size: 18px; color: #274360;">Sair</a></li>
                    </ul>  
                </div>
            </nav>
        </div>
        <!-- Content -->   
        <div class="row" style="width: 96%; background-color: #fff;
             border: 1px solid #e5e5e5;
             padding: 30px 30px 30px;
             margin: 30px!important;
             box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
             display: inline-block;">
            <center>
                <form action="ComprarItens" method="POST">   
                    <div class="col" style="width: 50%;">
                     <h2 style="margin-bottom: 40px; margin-top: 100px; color: #0277bd; text-align: center; font-size: 42px; ">Produtos</h2>
                        <select name="quarto" class="browser-default" style="width: 70%; margin-top: 10px; margin-bottom: 10px;">
                            <option disabled selected>Selecione o quarto</option>
                            <c:forEach items="${quarto}" var="quarto">                                                                                                                       
                                <option value="${quarto.id}">${quarto.quarto} | Cama Solteiro: ${quarto.camaSolteiro} | Cama Casal: ${quarto.camaCasal} | Cliente ${quarto.nome}</option>                                                                                       
                            </c:forEach>                                    
                        </select>

                        <select name="item" class="browser-default" style="width: 70%; margin-top: 5%; margin-bottom: 5%;">
                            <option disabled selected>Selecione o produto</option>
                            <c:forEach items="${todosItens}" var="item">                                                                                                                     
                                <option  <option value="${item.id}">${item.nome_item} | Valor: ${item.valor_item} | Quantidade: ${item.quantidade}</option>                                                                                      
                            </c:forEach>                                    
                        </select>
                  
                        <div class="input-field" style="width: 70%; margin-top: 5%;">
                            <input type="number" min="0" id="number" max="999" name="quantidade" class="form-control" required>
                            <label class="active">Quantidade</label>
                        </div>

                        <div class="bot">                                    
                            <%
                                //Traz a mensagem diretamente da control
                                String msg = (String) request.getAttribute("msg");
                                if (msg != null) {

                            %>
                            <font color="#274360"><%=msg%></font>
                            <%}%> 
                            <br>
                            <input class="btn btn-primary" style="width: 70%; background: #0277bd;" type="submit" name="acao" value="Comprar"><br><br>
                            <a href="indexCliente">Voltar</a>                                     
                        </div>
                    </div>
                </form>
                <div class="col"><img src="view/img/fotosHotel/coffee.png" alt="coffee" style="width: 500px;"></div>                      
            </center>
        </div>
        <!-- rodapé -->
        <footer class="page-footer" style=" background-color: #274360; text-align: center;">
            <div class="row" style=" text-align: center;">
                <div class="col s12 ">
                    <h5 style="font-size:18px; margin-top: 2vw; color: rgb(255,255,255,0.6)!important; ">&copy;2021 Breath Hotels Limitado</h5>
                </div>
            </div>
        </footer>
    </body>
</html>

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
    }
</script>
<%} else {
        response.sendRedirect("index");
    }%>

<script>
    const elemsDropdown = document.querySelectorAll(".dropdown-trigger");
    const instancesDropdown = M.Dropdown.init(elemsDropdown, {
        coverTrigger: false
    });
</script>   