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
import java.util.List;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "ControleQuarto", urlPatterns = {
    "/CadastroQuarto",
    "/ListarQuarto"})

public class ControleQuarto extends HttpServlet {

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
            if (acao.equals("Cadastrar")) {
                //Ao clicar em cadastrar no CadQuarto ele trarÃ¡ atÃ© esse servlet
                Quartos quartos = new Quartos();
                //Instancia na classe o que foi inserido nas caixas de texto
                quartos.setQuarto(request.getParameter("quarto"));
                quartos.setTipo(request.getParameter("tipo"));
                quartos.setCamaSolteiro(Integer.parseInt(request.getParameter("camaSolteiro")));
                quartos.setCamaCasal(Integer.parseInt(request.getParameter("camaCasal")));
                quartos.setDiaria(Double.parseDouble(request.getParameter("diaria")));

                //Valida se os dados nÃ£o estÃ£o vazios
                if (quartos.getDiaria() == 0 || quartos.getQuarto().equals("") || quartos.getTipo().equals("") || quartos.getCamaSolteiro() == 0 || quartos.getCamaCasal() == 0) {
                    RequestDispatcher rd = request.getRequestDispatcher("CadBedroom.jsp");
                    request.setAttribute("msg", "Há dados vazios, favor validar!");
                    rd.forward(request, response);
                } else {                                                            
                    QuartoDAO quartoDAO = new QuartoDAO();
                    //Instancia uma DAO e leva os dados atÃ© o mÃ©todo
                    quartoDAO.cadastraNovoQuarto(quartos);
                    
                    if(quartos.isQuarto_duplicado()){
                        RequestDispatcher rd = request.getRequestDispatcher("CadBedroom.jsp");
                        request.setAttribute("msg", "Este quarto já existe!");
                        rd.forward(request, response);
                    } else {
                        RequestDispatcher rd = request.getRequestDispatcher("CadBedroom.jsp");
                    request.setAttribute("msg", "Quarto cadastrado com sucesso!");
                    rd.forward(request, response);
                    }                                        
                }
            }
        } catch (NullPointerException erro) {
            RequestDispatcher rd = request.getRequestDispatcher("CadBedroom.jsp");
            request.setAttribute("msg", "Há dados vazios, favor validar");
            rd.forward(request, response);

        } catch (NumberFormatException erro) {
            RequestDispatcher rd = request.getRequestDispatcher("CadBedroom.jsp");
            request.setAttribute("msg", "Formato incorreto, favor validar!");
            rd.forward(request, response);

        } catch (Exception erro) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("msg", erro);
            rd.forward(request, response);
        }
    }

    private void listarQuarto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        QuartoDAO dao = new QuartoDAO();        

        //request.setAttribute("todosQuartos", todosQuartos);

        request.getRequestDispatcher("ListQuartos.jsp").forward(request, response);
    }
}
