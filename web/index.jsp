<%@page import="Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="view/styles/index.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <title>Breath Hotels</title>
    </head>
    <body>
        
     <!-- navbar -->
  <nav class="navbar navbar-expand-sm  navbar-dark" style="background-color: #274360;">
  <!-- Brand/logo -->
  
  
  <!-- Links -->
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="#">Link 1</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">Link 2</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">Link 3</a>
    </li>
  </ul>
  
  <ul class="navbar-nav ml-auto nav-flex-icons">
      
       <%
            //Valida se a sessão está valida
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            } else {
                //Traz a mensagem diretamente da control
                String login = usuario.getLogin();
                if (login != null) {
                }
        %>                             
        <h3  class="text-light" >Bem vindo, <%=login%> </h3>
        <%}%>  
        
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
          aria-haspopup="true" aria-expanded="false">
         <i class='fas fa-user-alt' style='font-size:24px;'></i>
        </a>
        <div class="dropdown-menu dropdown-menu-right dropdown-default"
          aria-labelledby="navbarDropdownMenuLink-333">
          <a class="dropdown-item" href="ListarUsuario">Usuários</a>
           <a class="dropdown-item" href="logout.jsp">Sair</a>
        </div>
      </li>
    </ul>
</nav>

        
     <!-- Menu lateral -->   
 <div class="sidenav">
     
 <div class="logo" style="background-image: url('view/img/icons/logo-white.jpg');  background-size: auto;"></div>
   <a href="#about"></a>
   <a href="#about"></a>
  
  <button class="dropdown-btn">Cadastros 
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="CadUser.jsp">Cadastro de Usuários</a>
    <a href="#">Cadastro de Cartões</a>
    <a href="CadBedroom.jsp">Cadastro de Quartos</a>
    <a href="CadItens.jsp">Cadastro de Itens</a>
  </div>
  <button class="dropdown-btn">Atualizar 
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="#">Atualizar Usuário</a>
    <a href="#">Atualizar Cartão</a>
    <a href="#">Atualizar Quarto</a>
     <a href="#">Atualizar Itens</a>
  </div>
  <button class="dropdown-btn">Reservas
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="#"></a>
    <a href="#">Check-in</a>
    <a href="#">Check-out</a>
  </div>
  <button class="dropdown-btn">Produtos
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="#">Comprar itens</a>
    <a href="#">Estoque</a>
  </div>
  <button class="dropdown-btn">Histórico
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="#">Link 1</a>
  </div>
  
</div>

<div class="main">
  
</div>

<script>
/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
  this.classList.toggle("active");
  var dropdownContent = this.nextElementSibling;
  if (dropdownContent.style.display === "block") {
  dropdownContent.style.display = "none";
  } else {
  dropdownContent.style.display = "block";
  }
  });
}
</script>
            
    </body>
</html>

