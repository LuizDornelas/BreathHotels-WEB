package Controle;

import DAO.CartaoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Modelo.Cartao;
import java.util.List;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "ControleCartao", urlPatterns = {
    "/CadastroCartao",
    "/ListarCartao",
    "/IniciarEdicaoCartao",
    "/ConfirmarEdicaoCartao",
    "/ExcluirCartao"})

public class ControleCartao extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/ListarCartao")) {
                listarCartao(request, response);
            }
            else if (uri.equals(request.getContextPath() + "/EditarCartao")) {
                //iniciarEdicao(request, response);
            } else if (uri.equals(request.getContextPath() + "/ExcluirCartao")) {
               // excluir(request, response);
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/CadastroCartao")) {
                CadastroCartao(request, response);
            } else if (uri.equals(request.getContextPath() + "/ConfirmarEdicaoCartao")) {
               // confirmarEdicao(request, response);
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
    private void CadastroCartao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        response.setContentType("text/html;charset=UTF-8");
        try {
            String acao = request.getParameter("acao");
            if (acao.equals("Cadastrar")) {
                //Ao clicar em cadastrar no CadCartao ele trarÃ¡ atÃ© esse servlet
                Cartao cartao = new Cartao();
                //Instancia na classe o que foi inserido nas caixas de texto
                cartao.setNumeroCartao(request.getParameter("numerocartao"));
                cartao.setNome(request.getParameter("nome"));
                cartao.setValidade(request.getParameter("validade"));
                cartao.setCodigo(Integer.parseInt(request.getParameter("codigo")));
                 cartao.setBandeira(request.getParameter("bandeira"));

                //Valida se os dados  não estão vazios
                if (cartao.getNumeroCartao().equals("") || cartao.getNome().equals("") || cartao.getValidade().equals("")|| cartao.getCodigo() == 0 || cartao.getBandeira().equals("")){
                    RequestDispatcher rd = request.getRequestDispatcher("CadCard.jsp");
                    request.setAttribute("msg", "Há dados vazios, favor validar!");
                    rd.forward(request, response);
                } else {                                                            
                    CartaoDAO cartaoDAO = new CartaoDAO();
                    //Instancia uma DAO e leva os dados até o metodo
                    cartaoDAO.cadastraNovoCartao(cartao);
                    
                    if(cartao.isCartao_duplicado()){
                        RequestDispatcher rd = request.getRequestDispatcher("CadCard.jsp");
                        request.setAttribute("msg", "Este cartão já existe!");
                        rd.forward(request, response);
                    } else {
                        RequestDispatcher rd = request.getRequestDispatcher("CadCard.jsp");
                    request.setAttribute("msg", "Cartão cadastrado com sucesso!");
                    rd.forward(request, response);
                    }                                        
                }
            }
                } catch (NullPointerException erro) {
                RequestDispatcher rd = request.getRequestDispatcher("CadCard.jsp");
                request.setAttribute("msg", "Há dados vazios, favor validar");
                rd.forward(request, response);

            } catch (NumberFormatException erro) {
                RequestDispatcher rd = request.getRequestDispatcher("CadCard.jsp");
                request.setAttribute("msg", "Formato incorreto, favor validar!");
                rd.forward(request, response);

            } catch (Exception erro) {
                RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                request.setAttribute("msg", erro);
                rd.forward(request, response);
            }
        }
    private void listarCartao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        CartaoDAO dao = new CartaoDAO();    
        
        List<Cartao> todosCartao = dao.consultarTodos();

        request.setAttribute("todosCartao", todosCartao);

        request.getRequestDispatcher("ListaCartao.jsp").forward(request, response);
    }
   /* private void iniciarEdicao(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ClassNotFoundException, SQLException, ServletException {
        try {

            Cartao cartao = new Cartao();
            CartaoDAO dao = new CartaoDAO();
            cartao.setId(Integer.valueOf(request.getParameter("id")));

            dao.consultarporId(cartao);

            request.setAttribute("cartao", cartao);
            request.getRequestDispatcher("EdCard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Erro.jsp");
        }
    }*/
  /*  private void confirmarEdicao(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ClassNotFoundException, SQLException, ServletException {
        try {
            Cartao cartao = new Cartao();
            CartaoDAO dao = new CartaoDAO();
            cartao.setNumeroCartao(Integer.parseInt(request.getParameter("numerocartao")));
            cartao.setNome(request.getParameter("nome"));
            cartao.setValidade(Integer.parseInt(request.getParameter("validade")));
            cartao.setCodigo(Integer.parseInt(request.getParameter("codigo")));
            cartao.setBandeira(request.getParameter("bandeira"));

            //Valida se os dados não estão vazios
            if (cartao.getNumeroCartao() == 0 || cartao.getNome().equals("") || cartao.getValidade() == 0 || cartao.getCodigo() == 0 || cartao.getBandeira().equals("")) {
                RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                request.setAttribute("erro", "Há dados vazios, favor validar!");
                rd.forward(request, response);
            } else {

                dao.Editar(cartao);

                response.sendRedirect("ListarCartao");

            }
        } catch (NullPointerException erro) {
                RequestDispatcher rd = request.getRequestDispatcher("CadCard.jsp");
                request.setAttribute("msg", "Há dados vazios, favor validar");
                rd.forward(request, response);

            } catch (NumberFormatException erro) {
                RequestDispatcher rd = request.getRequestDispatcher("CadCard.jsp");
                request.setAttribute("msg", "Formato incorreto, favor validar!");
                rd.forward(request, response);

            } catch (Exception erro) {
                RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                request.setAttribute("msg", erro);
                rd.forward(request, response);
        }
    }*/
   /*  private void excluir(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ClassNotFoundException, SQLException, ServletException {
        try {

            Cartao cartao = new Cartao();
            CartaoDAO dao = new CartaoDAO();
            cartao.setId(Integer.valueOf(request.getParameter("id")));

            dao.excluir(cartao);

            response.sendRedirect("ListarCartao");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Erro.jsp");
        }
    }*/
}
