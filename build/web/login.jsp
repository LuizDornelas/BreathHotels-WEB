<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>BreathHotels: LOGIN</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="view/fonts/iconic/css/material-design-iconic-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="view/styles/util.css">
        <link rel="stylesheet" type="text/css" href="view/styles/loginV2.css">
        <!--===============================================================================================-->
    </head>

    <body style="background-color: #999999;">

        <div class="limiter">
            <div class="container-login100">
                <div class="login100-more" style="background-image: url('view/img/fotosHotel/login1.jpg');  background-size: auto;"></div>

                <div class="wrap-login100 p-l-50 p-r-50 p-t-72 p-b-50">


                    <form class="login100-form validate-form" action="Login" method="POST">
                        <div>
                             <img src="view/img/icons/BreathLogo.png" alt="logo" style="width: 240px; height: 240px; margin-left: 43%; margin-bottom: 3vw; ">
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Digite seu Login!">
                            <span class="label-input100">Login</span>
                            <input class="input100" type="text" name="txt_login" placeholder="Digite Seu Login...">
                            <span class="focus-input100"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Digite sua Senha!">
                            <span class="label-input100">Senha</span>
                            <input class="input100" type="password" name="txt_senha" placeholder="*************">
                            <span class="focus-input100"></span>
                        </div>

                        <%
                            //Traz a mensagem diretamente da control
                            String msg = (String) request.getAttribute("msg");
                            if (msg != null) {
                        %>

                        <font color="red"> <%=msg%></font>
                        <%}%>        

                        <div>
                            <br>
                        </div>

                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn" type="submit" value="Entrar" name="acao">
                                    Entrar
                                </button>
                            </div>
                        </div>

                    </form>
                </div>

            </div>
        </div>

    </body>

</html>