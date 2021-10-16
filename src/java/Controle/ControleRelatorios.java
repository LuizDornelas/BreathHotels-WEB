package Controle;

import DAO.RelatorioDAO;
import Modelo.Relatorio;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "RelatorioControle", urlPatterns = {
    "/Relatorio",})

public class ControleRelatorios extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/Relatorio")) {
                relatorioReservas(request, response);
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }

    private void relatorioReservas(HttpServletRequest request, HttpServletResponse response) throws IOException, ClassNotFoundException, SQLException, ServletException {
        try {
        RelatorioDAO dao = new RelatorioDAO();

        List<Relatorio> reservasMes = dao.getReservaPorMes();

        request.setAttribute("reservaMes", reservasMes);
        request.getRequestDispatcher("Relatorios.jsp").forward(request, response);
        
        } catch (Exception e){
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
}
