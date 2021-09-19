<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <h1>Não foi possivel completar a ação, tente novamente!</h1>
        
        <%

        //Traz a mensagem diretamente da control
        String erro = (String) request.getAttribute("erro");
        if (erro != null) {

    %>
    <font color="red"><%=erro%></font>
    <%}%>
    </body>
</html>
