package Controle;

import DAO.CheckinDAO;
import DAO.QuartoDAO;
import DAO.UsuarioDAO;
import Modelo.Quartos;
import Modelo.Usuario;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ControleCheckin", urlPatterns = {
    "/Checkin",
    "/CadastraCheckin"})

public class ControleCheckin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/Checkin")) {
                checkin(request, response);
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

            if (uri.equals(request.getContextPath() + "/CadastraCheckin")) {
                cadastrar(request, response);
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }

    private void checkin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        QuartoDAO dao = new QuartoDAO();

        List<Quartos> quarto = dao.consultarDisponiveis();

        request.setAttribute("quarto", quarto);

        UsuarioDAO daoU = new UsuarioDAO();

        List<Usuario> user = daoU.consultarClientes();

        request.setAttribute("user", user);

        request.getRequestDispatcher("Checkin.jsp").forward(request, response);
    }

    private void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, ParseException {

        try {
            CheckinDAO dao = new CheckinDAO();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            LocalDateTime entrada = null;
            LocalDateTime saida = null;
            HttpSession session = request.getSession(true);
            Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");

            String parameter = request.getParameter("entrada");
            parameter = parameter.replace("T", " ");
            if (!"".equals(parameter)) {
                usuario.setEntrada(parameter);
                entrada = LocalDateTime.parse(parameter, formatter);
            }

            parameter = request.getParameter("saida");
            parameter = parameter.replace("T", " ");
            if (!"".equals(parameter)) {
                usuario.setSaida(parameter);
                saida = LocalDateTime.parse(parameter, formatter);
            }

            usuario.setQuarto(request.getParameter("cmb_quarto"));
            if (request.getParameter("cmb_cliente") != null) {
                usuario.setId(Integer.parseInt(request.getParameter("cmb_cliente")));
            }

            if (usuario.getEntrada() == null || usuario.getSaida() == null || usuario.getId() == 0) {
                RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                request.setAttribute("erro", "Há dados vazios, favor validar!");
                rd.forward(request, response);
            } else {
                long validaEntrada = Duration.between(LocalDateTime.now(), entrada).toDays();
                long validaSaida = Duration.between(entrada, saida).toDays();
                if (validaEntrada < 0) {
                    RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                    request.setAttribute("erro", "Data de entrada não pode ser menor que hoje!");
                    rd.forward(request, response);
                } else if (validaSaida < 0) {
                    RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                    request.setAttribute("erro", "Data de saída não pode ser menor que entrada!");
                    rd.forward(request, response);
                } else {
                    usuario.setDias((int) validaSaida);
                    dao.cadastrar(usuario);
                    response.sendRedirect("index");
                }
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
}
