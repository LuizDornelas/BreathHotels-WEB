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
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "Login", urlPatterns = {
    "/Login",
    "/index",
    "/indexCliente"})
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/index")) {
                reservas(request, response);
            } else if (uri.equals(request.getContextPath() + "/indexCliente")) {
                reservasCliente(request, response);
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

                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] messageDigest = md.digest(usuario.getSenha().getBytes());
                BigInteger number = new BigInteger(1, messageDigest);
                usuario.setSenha(number.toString(16));

                UsuarioDAO usuarioDAO = new UsuarioDAO();
                Usuario usuarioAutenticado = usuarioDAO.autenticaUsuario(usuario);

                if (usuarioAutenticado != null) {

                    if (usuarioAutenticado.isDesativado()) {
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        request.setAttribute("msg", "Usuário desativado, contate o administrador!");
                        rd.forward(request, response);
                    } else if ("Admin".equals(usuarioAutenticado.getTipo().toString()) || "Func".equals(usuarioAutenticado.getTipo().toString())) {

                        //Cria uma sessao para o usuario Admin ou Func
                        HttpSession sessaoUsuario = request.getSession();
                        sessaoUsuario.setAttribute("usuarioAutenticado", usuarioAutenticado);

                        //Redireciona para a pagina princiapal
                        response.sendRedirect("index");
                    } else {
                        //Se for usuário tipo cliente virá a essa etapa
                        HttpSession sessaoUsuario = request.getSession();
                        sessaoUsuario.setAttribute("usuarioAutenticado", usuarioAutenticado);

                        //Redireciona para a pagina princiapal
                        response.sendRedirect("indexCliente");
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

        request.setAttribute("todasReservas", todasReservas);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private void reservasCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        CheckinDAO dao = new CheckinDAO();

        HttpSession session = request.getSession(true);
        Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");

        List<Reserva> todasReservas = dao.consultarReservasCliente(usuario);

        request.setAttribute("todasReservas", todasReservas);

        request.getRequestDispatcher("indexCliente.jsp").forward(request, response);
    }
}
