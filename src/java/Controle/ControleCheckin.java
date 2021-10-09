 package Controle;

import DAO.QuartoDAO;
import DAO.UsuarioDAO;
import Modelo.Quartos;
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


@WebServlet(name = "ControleCheckin", urlPatterns = {
    "/Checkin"})

public class ControleCheckin extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
    }
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
        processRequest(request, response);
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
}
