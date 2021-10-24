<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <title>Error Page</title>

        <style>
            h1{
                text-align: Center;
                color: #295893;
                margin: 40px;
            }
            font{
                margin-left: 600px;
                color: red;
            }
            .xii{
                width: 600px;
                height: 600px;
                margin-top: 30px;
            }
            .ops{
                display: flex;
                justify-content: center;
            }
        </style>
    </head>
    <body>
        <h1>Não foi possivel completar a ação, tente novamente!</h1>
        <%

            //Traz a mensagem diretamente da control
            String erro = (String) request.getAttribute("erro");
            if (erro != null) {

        %>
        <font><%=erro%></font>
        <%}%>

    <center>
        <a href="javascript:history.back()">Voltar</a>
    </center>
    <div class="ops">
        <a href="#"><img src="view/img/fotosHotel/xiii.png" alt="ops" class="xii"></a>
    </div> 

</body>
</html>
