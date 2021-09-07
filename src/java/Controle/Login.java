package Controle;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import Modelo.Usuario;
import DAO.UsuarioDAO;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            String acao = request.getParameter("acao");
            if (acao.equals("Entrar")) {
                Usuario usuario = new Usuario();
                usuario.setLogin(request.getParameter("txt_login"));
                usuario.setSenha(request.getParameter("txt_senha"));

                UsuarioDAO usuarioDAO = new UsuarioDAO();
                Usuario usuarioAutenticado = usuarioDAO.autenticaUsuario(usuario);

                //Verifica se o usuario existe no banco
                if (usuarioAutenticado != null) {

                    if ("Admin".equals(usuarioAutenticado.getTipo().toString()) || "Func".equals(usuarioAutenticado.getTipo().toString())) {

                        //Cria uma sessao para o usuario Admin
                        HttpSession sessaoUsuario = request.getSession();
                        sessaoUsuario.setAttribute("usuarioAutenticado", usuarioAutenticado);

                        //Redireciona para a pagina princiapal
                        response.sendRedirect("index.jsp");
                    } else {
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        request.setAttribute("msg", "Login ou Senha Incorretos!");
                        rd.forward(request, response);
                    }

                } else {
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    request.setAttribute("msg", "Login ou Senha Incorretos!");
                    rd.forward(request, response);
                }
            } else if (acao.equals("Sair")) {
                HttpSession sessaoUsuario = request.getSession();
                sessaoUsuario.removeAttribute("usuarioAutenticado");
                response.sendRedirect("login.jsp");
            }
        } catch (Exception erro) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", erro);
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
