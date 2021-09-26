/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Modelo.Quartos;
import DAO.QuartoDAO;

@WebServlet(name = "ControleQuarto", urlPatterns = {
    "/CadastroQuarto",
    "/ListarQuarto"})

public class ControleQuarto {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/ListarQuarto")) {
                listarQuarto(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Erro.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/CadastroQuarto")) {
                cadastrarQuarto(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Erro.jsp");
        }
    }
    
    private void cadastrarQuarto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        
        response.setContentType("text/html;charset=UTF-8");
        try {
            String acao = request.getParameter("acao");
            if (acao.equals("CadastrarQuarto")) {
                //Ao clicar em cadastrar no CadQuarto ele trarÃ¡ atÃ© esse servlet
                Quartos quartos = new Quartos();
                //Instancia na classe o que foi inserido nas caixas de texto
                quartos.setQuarto(request.getParameter("txt_quarto"));
                quartos.setTipo(request.getParameter("txt_tipo"));
                quartos.setCamaSolteiro(request.getParameter("txt_telefone"));
                quartos.setCamaCasal(request.getParameter("txt_rua"));
                quartos.setStatus(request.getParameter("txt_numero"));
                quartos.setDiaria(request.getParameter("txt_bairro"));
                
                
               
                //Valida se os dados nÃ£o estÃ£o vazios
                if (quartos.getStatus().equals("") || quartos.getDiaria().equals("") || quartos.getQuarto().equals("") || quartos.getTipo().equals("") || quartos.getCamaSolteiro().equals("") || quartos.getCamaCasal().equals("")) {
                    RequestDispatcher rd = request.getRequestDispatcher("CadBedroom.jsp");
                    request.setAttribute("msg", "HÃ¡ dados vazios, favor validar!");
                    rd.forward(request, response);
                } else {

                    QuartoDAO quartoDAO = new QuartoDAO();
                    //Instancia uma DAO e leva os dados atÃ© o mÃ©todo
                    QuartoDAO.cadastraNovoQuarto(quartos);

                    
                }
            }
        } catch (NullPointerException erro) {
            RequestDispatcher rd = request.getRequestDispatcher("CadBedroom.jsp");
            request.setAttribute("msg", "HÃ¡ dados vazios, favor validar");
            rd.forward(request, response);

        } catch (Exception erro) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", erro);
            rd.forward(request, response);
        }
    }
    
    private void listarQuarto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        
        QuartoDAO dao = new QuartoDAO();
        
        List<Quartos> todosQuartos = dao.consultarTodos();
        
        request.setAttribute("todosQuartos", todosQuartos);
        
        request.getRequestDispatcher("ListQuartos.jsp").forward(request, response);
    }   
}
    
