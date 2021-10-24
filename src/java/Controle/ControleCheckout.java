package Controle;

import DAO.CheckoutDAO;
import Modelo.Cartao;
import Modelo.Consumo;
import Modelo.Usuario;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ControleCheckout", urlPatterns = {
    "/Checkout",
    "/CheckoutDados",
    "/PagamentoCartao"})
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
        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/PagamentoCartao")) {
                pagamentoCartao(request, response);
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
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
            String acao = request.getParameter("acao");
            if (acao.equals("Pagamento Cartao")) {
                Usuario user = new Usuario();
                Cartao card = new Cartao();
                CheckoutDAO dao = new CheckoutDAO();
                user.setId(Integer.valueOf(request.getParameter("reserva")));

                dao.consultarReservaCartao(user, card);

                if (card.isSem_cartao()) {
                    RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                    request.setAttribute("erro", "Usuário não tem cartão cadastrado!");
                    rd.forward(request, response);
                } else {
                    List<Consumo> todosConsumos = dao.consultarConsumo(user);
                    request.setAttribute("user", user);
                    request.setAttribute("cartao", card);
                    request.setAttribute("todosConsumos", todosConsumos);
                    request.getRequestDispatcher("PagamentoCartao.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }

    private void pagamentoCartao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

            LocalDateTime agora = LocalDateTime.now();                        

            String parameter = agora.format(formatter);                       

            Usuario user = new Usuario();            
            CheckoutDAO dao = new CheckoutDAO();
            user.setId(Integer.valueOf(request.getParameter("reserva")));
            user.setSaida(parameter);
            user.setDiaria(Double.parseDouble(request.getParameter("total")));
            
            dao.pagamentoCartao(user);

            response.sendRedirect("index");
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
}
