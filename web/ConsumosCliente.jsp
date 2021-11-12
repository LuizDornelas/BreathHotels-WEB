<%@page import="Modelo.Reserva"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <title>Lista de Consumos</title>
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
        <nav style="background-color: #274360; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); margin-bottom: 5vw; height: 100px;">
            <div class="nav-wrapper">
                <a href="#!" class="brand-logo"><img src="view/img/icons/BreathHotels-logo-white.png" alt="logo" style="width: 250px; margin: 10px;"></a>  
                <ul class="right hide-on-med-and-down" style=" margin-top: 1.8vw; ">
                    <li><a href="indexCliente" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Home</a></li>   
                    <li><a href="ItensDeCompra" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Comprar itens</a></li>  
                    <li><a href="Encerradas" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Reservas encerradas</a></li>  
                    <li><a href="Consumo" style="font-size: 18px; color: rgb(255,255,255,0.6)!important;">Histórico de consumo</a></li>

                    <ul class="left hide-on-med-and-down">  

                        <h2  class="text-light" style="font-size: 18px; color: rgb(255,255,255,0.6)!important; margin-top: 32%;">Olá, <%=login%></h2>
                    </ul>
                    <li><a class="dropdown-trigger" style="font-size: 18px; color: rgb(255,255,255,0.6)!important; margin-right: 1vw;"  href="#!" data-target="dropdown4"><i class="material-icons right" style="font-size: 30px; margin-bottom: 20%;">account_circle</i></a>
                </ul>
                <ul id="dropdown4" class="dropdown-content">  
                    <li><a href="logout.jsp" style="font-size: 18px; color: #274360;">Sair</a></li>
                </ul>  
            </div>
        </nav>
            <center> 
                <h3 class="cyan-text text-cyan darken-2">Consumos</h3>
                <table class="striped highlight responsive-table" border="1">
                    <input type="text" style="" id="search" class="form-control" placeholder="Busca por reserva"/><br>  
                    <tr>                
                        <th style="width: 5%;">Reserva</th>
                        <th style="width: 10%;">Item</th>
                        <th style="width: 10%;">Valor</th>
                        <th style="width: 10%;">Quantidade</th>
                        <th style="width: 10%;">Data</th>                                  
                    </tr>
            </center>

            <c:forEach items="${todosConsumos}" var="consumo">
                <tr>                                           
                    <td id="reserva" align="center">${consumo.reserva}</td>
                    <td align="center">${consumo.item}</td>
                    <td align="center">${consumo.valor}</td>
                    <td align="center">${consumo.quantidade}</td>
                    <td align="center">${consumo.data}</td>                                
                </tr>
            </c:forEach>
        </table>

        <br><br>
        <a class="btn btn-outline-secondary" href="indexCliente">Voltar</a>        
        <br><br>
    </div>
</body>
</html>
<script>

    $('#search').keyup(function () {
        var regex = new RegExp($('#search').val(), "i");
        var rows = $('table tr:gt(0)');
        rows.each(function (index) {
            title = $(this).children("#reserva").html()
            if (title.search(regex) != -1) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
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