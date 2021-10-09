package Controle;

import DAO.CheckinDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import Modelo.Usuario;
import DAO.UsuarioDAO;
import Modelo.Reserva;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "Login", urlPatterns = {
    "/Login",
    "/index"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {              
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/index")) {
                reservas(request, response);
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/Login")) {
                login(request, response);
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
    
    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        try {

            String acao = request.getParameter("acao");
            if (acao.equals("Entrar")) {
                //Ao clicar em entrar no login o trará até esse servlet
                Usuario usuario = new Usuario();
                //Instancia o que foi escrito nas caixas de texto até a classe instancia anteriormente
                usuario.setLogin(request.getParameter("txt_login"));
                usuario.setSenha(request.getParameter("txt_senha"));

                UsuarioDAO usuarioDAO = new UsuarioDAO();
                Usuario usuarioAutenticado = usuarioDAO.autenticaUsuario(usuario);

                //Verifica se o usuario existe no banco
                if (usuarioAutenticado != null) {

                    if ("Admin".equals(usuarioAutenticado.getTipo().toString()) || "Func".equals(usuarioAutenticado.getTipo().toString())) {

                        //Cria uma sessao para o usuario Admin ou Func
                        HttpSession sessaoUsuario = request.getSession();
                        sessaoUsuario.setAttribute("usuarioAutenticado", usuarioAutenticado);

                        //Redireciona para a pagina princiapal
                        response.sendRedirect("index");
                    } else {
                        //Se for usuário tipo cliente virá a essa etapa
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        request.setAttribute("msg", "Tipo de login não permitido no momento");
                        rd.forward(request, response);
                    }

                } else {
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    request.setAttribute("msg", "Login ou Senha Incorretos!");
                    rd.forward(request, response);
                }
            }
        } catch (Exception erro) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", erro);
            rd.forward(request, response);
        }
    }
    private void reservas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        CheckinDAO dao = new CheckinDAO();        

        List<Reserva> todasReservas = dao.consultarReservas();
        
        boolean validaDados;
        
        if(todasReservas != null){
            validaDados = true;
        } else{
            validaDados = false;
        }
        
        request.setAttribute("todasReservas", todasReservas);
        request.setAttribute("validaDados", validaDados);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
