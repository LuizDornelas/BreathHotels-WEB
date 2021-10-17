package Controle;

import DAO.CheckoutDAO;
import Modelo.Consumo;
import Modelo.Usuario;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ControleCheckout", urlPatterns = {
    "/Checkout",
    "/CheckoutDados"})
public class ControleCheckout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/Checkout")) {
                checkout(request, response);
            } else if (uri.equals(request.getContextPath() + "/CheckoutDados")) {
                checkoutDados(request, response);
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

    }

    private void checkout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        CheckoutDAO dao = new CheckoutDAO();

        List<Usuario> user = dao.consultarReservas();

        request.setAttribute("user", user);

        request.getRequestDispatcher("Checkout.jsp").forward(request, response);
    }

    private void checkoutDados(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ClassNotFoundException, SQLException, ServletException {
        try {

            Usuario user = new Usuario();
            CheckoutDAO dao = new CheckoutDAO();
            user.setId(Integer.valueOf(request.getParameter("reserva")));

            dao.consultarporReserva(user);
            List<Consumo> todosConsumos = dao.consultarConsumo(user);           

            request.setAttribute("user", user);
            request.setAttribute("todosConsumos", todosConsumos);            
            request.getRequestDispatcher("CheckoutDados.jsp").forward(request, response);

        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
}
