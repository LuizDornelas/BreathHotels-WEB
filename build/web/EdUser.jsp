<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Atualiza Usuários</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <link rel="icon" type="image/png" href="view/img/icons/logo-hotel.ico">
        <link rel="stylesheet" type="text/css" href="view/styles/index.css">        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">     
    </head>
    <body id="conteudo">  
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
        <!-- cadastro --> 
        <div class="row" style="width: 96%;">
            <center>
                <form action="ConfirmarEdicao" method="POST">   
                    <div class="col" style="width: 40%;">
                        <h2 style="margin-bottom: 40px; margin-top: 55px; color: #0277bd; text-align: center; font-size: 42px; ">Cadastro de Usuários</h2>

                        <div class="input-field">                                    
                            <input type="hidden" name="txt_id" class="form-control" value="${usuario.id}">
                        </div>

                        <div class="input-field" style="width: 80%;">
                            <input type="text" name="txt_nome" maxlength="80" class="form-control" value="${usuario.nome}">
                            <label class="active">Nome</label>
                        </div>

                        <div class="input-field" style="width: 80%;">
                            <input type="text" name="txt_rg" maxlength="13" OnKeyPress="formatar('##.###.###-##', this)" class="form-control"  value="${usuario.rg}">
                            <label class="active">Documento de identidade</label>
                        </div>

                        <div class="input-field" style="width: 80%;">
                            <input type="text" name="txt_telefone" onkeydown="phoneMask()" maxlength="15" class="form-control" value="${usuario.telefone}">
                            <label class="active">Telefone</label>
                        </div>

                        <div class="input-field" style="width: 80%;">
                            <input type="text" name="txt_rua" maxlength="40" class="form-control" value="${usuario.rua}">
                            <label class="active">Rua</label>
                        </div>

                        <div class="input-field" style="width: 80%;">
                            <input type="number" min="0" id="number" max="9999" name="txt_numero" class="form-control" value="${usuario.numero}">
                            <label class="active">Número</label>
                        </div>

                        <div class="input-field" style="width: 80%;">
                            <input type="text" name="txt_bairro" maxlength="40" class="form-control" value="${usuario.bairro}">
                            <label class="active">Bairro</label>
                        </div>

                        <div  class="input-field" style="width: 80%;">
                            <input type="text" name="txt_cidade" maxlength="40" class="form-control" value="${usuario.cidade}" >
                            <label class="active">Cidade</label>
                        </div>

                        <div class="input-field" style="width: 80%;">
                            <input type="text" name="txt_estado" maxlength="40" class="form-control" value="${usuario.estado}" >
                            <label class="active">Estado</label>
                        </div>

                        <div  class="input-field" style="width: 80%;">
                            <input type="text" name="txt_cep" maxlength="9" OnKeyPress="formatar('#####-###', this)" class="form-control" value="${usuario.cep}">
                            <label class="active">CEP</label>
                        </div>

                        <div class="input-field" style="width: 80%;">
                            <input type="text" name="txt_login" maxlength="20" class="form-control" value="${usuario.login}">
                            <label class="active">Login</label>
                        </div>
                            <%
                                //Valida se é Func ou Admin, conforme login terá tipos diferentes de usuário para cadastrar
                                if ("Admin".equals(usuario.getTipo().toString())) {
                            %>
                            <select name="cmb_tipo" class="browser-default" style="width: 80%; margin-bottom: 10px;">
                                <option disabled selected>Selecione o Tipo</option>                                                                                                                                            
                                <option>Admin</option>
                                <option>Func</option>
                                <option>Cliente</option>                                                                                                                                                 
                            </select>
                            <%} else {%> 
                            <select name="cmb_tipo" class="browser-default" style="width: 80%;">
                                <option>Func</option>
                                <option>Cliente</option> 
                            </select>
                            <%}%>                           
                            <select name="cmb_ativo" class="browser-default" style="width: 80%;">   
                                <option disabled selected>Ativo:</option>
                                <option>SIM</option>
                                <option>NAO</option>
                            </select> 
                        
                        <div class="bot">                                    
                            <%
                                //Traz a mensagem diretamente da control
                                String msg = (String) request.getAttribute("msg");
                                if (msg != null) {

                            %>
                            <font color="#274360"><%=msg%></font>
                            <%}%> 
                            <br>

                            <input class="btn btn-primary" style="width: 80%; background: #0277bd;" type="submit" name="acao" value="Atualizar"><br><br>
                            <a href="ListarUsuario">Voltar</a> 
                            </br>
                        </div>                    
                    </div>
                </form>
                <div class="col"><img src="view/img/fotosHotel/cadastro.jpg" alt="Porta azul" style="width: 52vw; margin-top: 30px; "></div>                      
            </center>
        </div> 

        <footer>
            <!-- rodapé -->
            <p style='font-size:18px; margin-top: 3vw; color: rgb(255,255,255,0.6)!important;'>&copy;2021 Breath Hotels Limitado</p>
        </footer> 
    </body>
</html>
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
        response.sendRedirect("indexCliente");
    }%>

<script>
    // NavBar
    const elemsDropdown = document.querySelectorAll(".dropdown-trigger");
            const instancesDropdown = M.Dropdown.init(elemsDropdown, {
            coverTrigger: false
            });
</script>