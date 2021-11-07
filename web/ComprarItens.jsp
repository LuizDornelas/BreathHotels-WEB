<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <title>Comprar itens</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico">
        <link rel="stylesheet" type="text/css" href="view/styles/Estoque.css">        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>
    <body class="conteudo">  
       <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
        %>
        <!-- header --> 
        <div class="navbar-fixed" style=" margin-bottom: 10vw;">
        <nav style="background-color: #274360; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); margin-bottom: 5vw; height: 100px;">
            <div class="nav-wrapper">
                <a href="index" class="brand-logo"><img src="view/img/icons/BreathHotels-logo-white.png" alt="logo" style="width: 250px; margin: 10px;"></a>
                <ul class="right hide-on-med-and-down" style=" margin-top: 1.8vw; ">
                    <li><a href="ListarUsuario" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Usuários</a></li>
                    <li><a href="ListarQuarto" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Quartos</a></li>
                    <li><a href="ListarCartao" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Cartões</a></li>
                    <li><a href="Relatorio" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Relatório</a></li>
                    <!-- Dropdown Trigger -->
                    <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;" href="#!" data-target="dropdown1">Histórico<i class="material-icons right">arrow_drop_down</i></a></li>
                    <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;" href="#!" data-target="dropdown2">Reservas<i class="material-icons right">arrow_drop_down</i></a></li>
                    <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;" href="#!" data-target="dropdown3">Produtos<i class="material-icons right">arrow_drop_down</i></a></li>
                    <ul class="left hide-on-med-and-down">
                    <%
                        //Traz a mensagem diretamente da control
                        String login = usuario.getLogin();
                        if (login != null) {
                        }
                    %> 
                    <h2  class="text-light" style="font-size: 18px; color: rgb(255,255,255,0.6)!important; margin-top: 32%;">Olá, <%=login%></h2>
                    </ul>
                    <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important; margin-right: 1vw;"  href="#!" data-target="dropdown4"><i class="material-icons right" style="font-size: 30px; margin-bottom: 20%;">account_circle</i></a>
                </ul>

                <ul id="dropdown1" class="dropdown-content">
                    <li><a href="ReservasEncerradas" style="font-size: 18px; color: #274360;">Reservas</a></li>
                    <li><a href="Consumos" style="font-size: 18px; color: #274360;">Consumos</a></li>
                    <li class="divider"></li>
                </ul>
                <ul id="dropdown2" class="dropdown-content">
                    <li><a href="Checkin" style="font-size: 18px; color: #274360;">Check-in</a></li>
                    <li><a href="Checkout" style="font-size: 18px; color: #274360;">Check-out</a></li>
                    <li class="divider"></li>
                </ul>
                <ul id="dropdown3" class="dropdown-content">
                    <li><a  href="ListarItensDeCompra" style="font-size: 18px; color: #274360;">Comprar itens</a></li>
                    <li><a href="ListarItem" style="font-size: 18px; color: #274360;">Estoque</a></li>
                    <li class="divider"></li>
                </ul>
                <ul id="dropdown4" class="dropdown-content">  
                     <li><a href="logout.jsp" style="font-size: 18px; color: #274360;">Sair</a></li>
                </ul>        

            </div>
        </nav>
        </div>

        <div class="row" style="width: 95%;">
            <center>
                <form action="ComprarItens" method="POST">   
                    <div class="col" style="width: 50%;">
                        <h2 class="texto4" style="margin-bottom: 40px; margin-top: 100px; color: #274360;text-align: center; font-size: 42px; ">Produtos</h2>

                        <label style="margin-top: 10%; margin-right: 50%; margin-bottom: 10%;">Quarto</label>
                        <select name="quarto" class="browser-default" style="width: 60%; margin-top: 10px; margin-bottom: 10px;">
                            <option disabled selected>Selecione o quarto</option>
                            <c:forEach items="${quarto}" var="quarto">                                                                                                                       
                                <option value="${quarto.id}">${quarto.quarto} | Cama Solteiro: ${quarto.camaSolteiro} | Cama Casal: ${quarto.camaCasal} | Cliente ${quarto.nome}</option>                                                                                       
                            </c:forEach>                                    
                        </select>

                        <label style="margin-right: 50%;">Produto</label>
                        <select name="item" class="browser-default" style="width: 60%; margin-top: 10px; margin-bottom: 10px;">
                            <option disabled selected>Selecione o produto</option>
                            <c:forEach items="${todosItens}" var="item">                                                                                                                     
                                <option  <option value="${item.id}">${item.nome_item} | Valor: ${item.valor_item} | Quantidade: ${item.quantidade}</option>                                                                                      
                            </c:forEach>                                    
                        </select>

                        <label style="margin-top: 10px!important; margin-right: 46%">Quantidade</label>
                        <div class="form-group">
                            <input  style="width: 60%; margin-top: 10px;" type="number" min="0" id="number" max="999" name="quantidade" class="form-control" required>                                    
                        </div>

                        <div class="bot">                                    
                            <%
                                //Traz a mensagem diretamente da control
                                String msg = (String) request.getAttribute("msg");
                                if (msg != null) {

                            %>
                            <font color="#274360"><%=msg%></font>
                            <%}%> 
                            <br><br> 

                            <input class="btn btn-primary" style="width: 60%;" type="submit" name="acao" value="Comprar"><br><br>
                            <a href="index">Voltar</a>                                     
                        </div>
                    </div>
                </form>
                <div class="col"><img src="view/img/fotosHotel/coffee.png" alt="coffee" style="width: 500px;"></div>                      
            </center>
        </div> 

        <footer>
            <!-- rodapé -->
            <p style='font-size:18px; margin-top: 3vw; color: rgb(255,255,255,0.6)!important;'>&copy;2021 Breath Hotels Limitado</p>
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
       // NavBar
        const elemsDropdown = document.querySelectorAll(".dropdown-trigger");
        const instancesDropdown = M.Dropdown.init(elemsDropdown,{
            coverTrigger: false
        }); 
</script>
<%} else {
        response.sendRedirect("indexCliente");
    }%>