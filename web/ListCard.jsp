<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />    
        <link rel="stylesheet" type="text/css" href="view/styles/index.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <title>Lista de Cartões</title>
    </head>
    <body id="conteudo">  
        <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
        %>
        <!-- Header --> 
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
        <!-- lista --> 
        <div class="listando">
            <center>   
                <h3 class="res" style="margin-bottom: 40px;" >Cartões</h3>
                <table class="striped highlight" border="1">
                    <input type="text" style="" id="search" class="form-control" placeholder="Busca cartão por usuário"/><br>  
                    <tr>         
                        <th style="width: 10%;">Usuário</th>
                        <th style="width: 10%;">Número do cartão</th>
                        <th style="width: 10%;">Nome Cartão</th>
                        <th style="width: 5%;">Validade</th>
                        <th style="width: 5%;">Código</th>
                        <th style="width: 10%;">Bandeira</th>
                        <th style="width: 1%;">Editar</th>
                        <th style="width: 1%;">Excluir</th>
                    </tr>
            </center>
            <c:forEach items="${todosCartao}" var="cartao">
                <tr>          
                    <td id="user" align="center">${cartao.nome_cliente}</td>
                    <td align="center">${cartao.numero}</td>
                    <td align="center">${cartao.nome}</td>
                    <td align="center">${cartao.validade}</td>
                    <td align="center">${cartao.codigo}</td>
                    <td align="center">${cartao.bandeira}</td>            
                    <td align="center"><a style="color: #0277bd" href="IniciarEdicaoCartao?id=${cartao.id}" alt="">Editar</a></td>  
                    <td align="center"><a style="color: #0277bd" href="ExcluirCartao?id=${cartao.id}" alt="">Excluir</a></td>  
                </tr>
            </c:forEach>
        </table>        
        <br><br>
        <a class="btn btn-outline-secondary" style="background: #0277bd" href="index">Voltar</a>  
        <a class="btn btn-outline-primary" style="background: #0277bd" href="CadCard">Cadastrar Cartao</a>        
    </div>
    <footer>
        <!-- rodapé -->
        <p style='font-size:18px; margin-top: 3vw; color: rgb(255,255,255,0.6)!important;'>&copy;2021 Breath Hotels Limitado</p>
    </footer> 
</body>
</html>
<script>

    $('#search').keyup(function () {
        var regex = new RegExp($('#search').val(), "i");
        var rows = $('table tr:gt(0)');
        rows.each(function (index) {
            title = $(this).children("#user").html()
            if (title.search(regex) != -1) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });

    // NavBar
    const elemsDropdown = document.querySelectorAll(".dropdown-trigger");
    const instancesDropdown = M.Dropdown.init(elemsDropdown, {
        coverTrigger: false
    });
</script>
<%} else {
        response.sendRedirect("indexCliente");
    }%>