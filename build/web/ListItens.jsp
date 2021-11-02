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
        <title>Lista de Itens</title>
    </head>
    <body class="conteudo">     
        <div class="listando">
            <%
                //Valida se a sessão está valida
                Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
                if (usuario == null) {
                    response.sendRedirect("login.jsp");
                } else if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
            %>
            <center>   
                <h3 class="cyan-text text-cyan darken-2" style="margin-bottom: 40px;">Itens</h3>
                <table class="striped highlight" border="1">
                    <input type="text" style="" id="search" class="form-control" placeholder="Busca item"/><br>  
                    <tr>                
                        <th style="width: 10%;">Item</th>
                        <th style="width: 10%;">Valor</th>
                        <th style="width: 5%;">Quantidade</th>
                        <th style="width: 5%;">Status</th>
                        <th style="width: 10%;">Fornecedor</th>
                        <th style="width: 5%;">Valor Compra</th>
                        <th style="width: 1%;">Editar</th>
                        <th style="width: 1%;">Excluir</th>
                    </tr>
            </center>

            <c:forEach items="${todosItens}" var="item">
                <tr>            
                    <td id="item" align="center">${item.nome_item}</td>
                    <td align="center">R$${item.valor_item}0</td>
                    <td align="center">${item.quantidade}</td>
                    <td align="center">${item.status}</td>
                    <td align="center">${item.nome_fornecedor}</td>
                    <td align="center">R$${item.valor_compra}0</td>
                    <td align="center"><a href="IniciarEdicaoItem?id=${item.id}" alt="">Editar</a></td>     
                    <td align="center"><a href="ExcluirItem?id=${item.id}" alt="">Excluir</a></td>  
                </tr>
            </c:forEach>
        </table>

        <br><br>
        <a class="btn btn-outline-secondary" href="index">Voltar</a>  
        <a class="btn btn-outline-primary" href="CadItens.jsp">Cadastrar Itens</a>        
    </div>
</body>
</html>
<script>

    $('#search').keyup(function () {
        var regex = new RegExp($('#search').val(), "i");
        var rows = $('table tr:gt(0)');
        rows.each(function (index) {
            title = $(this).children("#item").html()
            if (title.search(regex) != -1) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
</script>
<%} else {
        response.sendRedirect("indexCliente");
    }%>