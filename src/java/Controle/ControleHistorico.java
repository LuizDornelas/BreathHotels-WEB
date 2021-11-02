/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import DAO.HistoricoDAO;
import Modelo.Historico;
import Modelo.Reserva;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author luiz.dornelas
 */
@WebServlet(name = "ControleHistorico", urlPatterns = {
    "/ReservasEncerradas",
    "/Consumos",
    "/Encerradas",
    "/Consumo"})
public class ControleHistorico extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/ReservasEncerradas")) {
                listarReservas(request, response);
            } else if (uri.equals(request.getContextPath() + "/Consumos")) {
                listarConsumos(request, response);
            } else if (uri.equals(request.getContextPath() + "/Encerradas")) {
                reservasEncerradas(request, response);
            } else if (uri.equals(request.getContextPath() + "/Consumo")) {
                listarConsumosCliente(request, response);
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

    private void listarReservas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        HistoricoDAO dao = new HistoricoDAO();

        List<Historico> todasReservas = dao.consultarReservas();

        request.setAttribute("todasReservas", todasReservas);

        request.getRequestDispatcher("ListReservas.jsp").forward(request, response);
    }

    private void listarConsumos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        HistoricoDAO dao = new HistoricoDAO();

        List<Historico> todosConsumos = dao.consultarConsumos();

        request.setAttribute("todosConsumos", todosConsumos);

        request.getRequestDispatcher("ListConsumos.jsp").forward(request, response);
    }

    private void listarConsumosCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        HistoricoDAO dao = new HistoricoDAO();
        
        HttpSession session = request.getSession(true);
        Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");
        
        List<Historico> todosConsumos = dao.consultarConsumosCliente(usuario);

        request.setAttribute("todosConsumos", todosConsumos);

        request.getRequestDispatcher("ConsumosCliente.jsp").forward(request, response);
    }

    private void reservasEncerradas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        HistoricoDAO dao = new HistoricoDAO();

        HttpSession session = request.getSession(true);
        Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");

        List<Reserva> todasReservas = dao.consultarReservasEncerradas(usuario);

        request.setAttribute("todasReservas", todasReservas);

        request.getRequestDispatcher("ReservasEncerradas.jsp").forward(request, response);
    }
}
