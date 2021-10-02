package Controle;

import DAO.ItemDAO;
import Modelo.Itens;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "ControleItens", urlPatterns = {
    "/CadastroItem",
    "/ListarItem",
    "/IniciarEdicaoItem",
    "/ConfirmarEdicaoItem",
    "/ExcluirItem"})

public class ControleItens extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/ListarItem")) {
                listar(request, response);
            } else if (uri.equals(request.getContextPath() + "/IniciarEdicaoItem")) {
                //iniciarEdicao(request, response);
            } else if (uri.equals(request.getContextPath() + "/ExcluirItem")) {
                //excluir(request, response);
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

            if (uri.equals(request.getContextPath() + "/CadastroItem")) {
                cadastrar(request, response);
            } else if (uri.equals(request.getContextPath() + "/ConfirmarEdicaoItem")) {
                //confirmarEdicao(request, response);
            }
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
    private void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        response.setContentType("text/html;charset=UTF-8");
        try {
            String acao = request.getParameter("acao");
            if (acao.equals("Cadastrar")) {
                //Ao clicar em cadastrar no CadItens ele trará até esse servlet
                Itens item = new Itens();
                
                item.setNome_item(request.getParameter("txt_item"));
                item.setValor_item(Double.parseDouble(request.getParameter("txt_valor_item")));
                item.setValor_compra(Double.parseDouble(request.getParameter("txt_valor_compra")));
                item.setQuantidade(Integer.parseInt(request.getParameter("txt_quantidade")));
                item.setNome_fornecedor(request.getParameter("txt_nome_fornecedor"));
                
                //Valida se os dados não estão vazios
                if (item.getNome_item().equals("") || item.getValor_item() == 0 || item.getValor_compra() == 0 || item.getQuantidade() == 0 || item.getNome_fornecedor().equals("")) {
                    RequestDispatcher rd = request.getRequestDispatcher("CadItens.jsp");
                    request.setAttribute("msg", "Há dados vazios, favor validar!");
                    rd.forward(request, response);
                } else {

                    ItemDAO itemDAO = new ItemDAO();
                    
                    //Instancia uma DAO e leva os dados até o método
                    itemDAO.cadastraNovoItem(item);

                    if (item.isItem_duplicado()) {
                        RequestDispatcher rd = request.getRequestDispatcher("CadItens.jsp");
                        request.setAttribute("msg", "Este Item já existe!");
                        rd.forward(request, response);
                    } else {
                        RequestDispatcher rd = request.getRequestDispatcher("CadItens.jsp");
                        request.setAttribute("msg", "Item cadastrado com sucesso!");
                        rd.forward(request, response);
                    }
                }
            }
        } catch (NullPointerException erro) {
            RequestDispatcher rd = request.getRequestDispatcher("CadItens.jsp");
            request.setAttribute("msg", "Há dados vazios, favor validar");
            rd.forward(request, response);

        } catch (Exception erro) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", erro);
            rd.forward(request, response);
        }
    }
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        ItemDAO dao = new ItemDAO();

        List<Itens> todosItens = dao.consultarTodos();

        request.setAttribute("todosItens", todosItens);

        request.getRequestDispatcher("ListItens.jsp").forward(request, response);
    }
}
