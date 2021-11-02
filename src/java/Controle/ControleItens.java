package Controle;

import DAO.ItemDAO;
import DAO.QuartoDAO;
import Modelo.Itens;
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
import javax.servlet.http.HttpSession;

@WebServlet(name = "ControleItens", urlPatterns = {
    "/CadastroItem",
    "/ListarItem",
    "/IniciarEdicaoItem",
    "/ConfirmarEdicaoItem",
    "/ExcluirItem",
    "/ListarItensDeCompra",
    "/ComprarItens",
    "/ItensDeCompra"})

public class ControleItens extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/ListarItem")) {
                listar(request, response);
            } else if (uri.equals(request.getContextPath() + "/IniciarEdicaoItem")) {
                iniciarEdicao(request, response);
            } else if (uri.equals(request.getContextPath() + "/ExcluirItem")) {
                excluir(request, response);
            } else if (uri.equals(request.getContextPath() + "/ListarItensDeCompra")) {
                listarCompras(request, response);
            } else if (uri.equals(request.getContextPath() + "/ItensDeCompra")) {
                listarComprasCliente(request, response);
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
                confirmarEdicao(request, response);
            } else if (uri.equals(request.getContextPath() + "/ComprarItens")) {
                comprarItens(request, response);
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
            request.setCharacterEncoding("UTF-8");
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
                if (item.getNome_item().equals("") || item.getValor_item() == 0 || item.getValor_compra() == 0 || item.getNome_fornecedor().equals("")) {
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

    private void comprarItens(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        response.setContentType("text/html;charset=UTF-8");
        try {
            request.setCharacterEncoding("UTF-8");

            //Ao clicar em cadastrar no CadItens ele trará até esse servlet
            Itens item = new Itens();

            item.setId_quarto(Integer.parseInt(request.getParameter("quarto")));
            item.setId(Integer.parseInt(request.getParameter("item")));
            item.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));

            if (item.getQuantidade() <= 0) {

                RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                request.setAttribute("erro", "Quantidade inválida!");
                rd.forward(request, response);

            } else {
                //Valida se os dados não estão vazios
                ItemDAO itemDAO = new ItemDAO();

                //Instancia uma DAO e leva os dados até o método
                itemDAO.comprarItem(item);

                if (item.isItem_valicacao()) {
                    RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                    request.setAttribute("erro", "Quantidade maior que o estoque!");
                    rd.forward(request, response);
                } else {

                    HttpSession session = request.getSession(true);
                    Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");

                    if ("Admin".equals(usuario.getTipo().toString()) || "Func".equals(usuario.getTipo().toString())) {
                        response.sendRedirect("index");
                    } else {
                        response.sendRedirect("indexCliente");
                    }
                }
            }
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

    private void listarCompras(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        QuartoDAO dao = new QuartoDAO();

        List<Quartos> quarto = dao.consultarReservas();

        request.setAttribute("quarto", quarto);

        ItemDAO dao2 = new ItemDAO();

        List<Itens> todosItens = dao2.consultarDisponiveis();

        request.setAttribute("todosItens", todosItens);

        request.getRequestDispatcher("ComprarItens.jsp").forward(request, response);
    }

    private void listarComprasCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        QuartoDAO dao = new QuartoDAO();

        HttpSession session = request.getSession(true);
        Usuario usuario = (Usuario) session.getAttribute("usuarioAutenticado");

        List<Quartos> quarto = dao.consultarReservasCliente(usuario);

        request.setAttribute("quarto", quarto);

        ItemDAO dao2 = new ItemDAO();

        List<Itens> todosItens = dao2.consultarDisponiveis();

        request.setAttribute("todosItens", todosItens);

        request.getRequestDispatcher("comprarItensCliente.jsp").forward(request, response);
    }

    private void iniciarEdicao(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ClassNotFoundException, SQLException, ServletException {
        try {

            Itens item = new Itens();
            ItemDAO dao = new ItemDAO();
            item.setId(Integer.valueOf(request.getParameter("id")));

            dao.consultarporId(item);

            request.setAttribute("item", item);
            request.getRequestDispatcher("EdItens.jsp").forward(request, response);

        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }

    private void confirmarEdicao(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ClassNotFoundException, SQLException, ServletException {
        try {
            request.setCharacterEncoding("UTF-8");
            Itens item = new Itens();
            ItemDAO dao = new ItemDAO();
            item.setId(Integer.valueOf(request.getParameter("txt_id")));
            item.setNome_item(request.getParameter("txt_item"));
            item.setValor_item(Double.parseDouble(request.getParameter("txt_valor_item")));
            item.setValor_compra(Double.parseDouble(request.getParameter("txt_valor_compra")));
            item.setQuantidade(Integer.parseInt(request.getParameter("txt_quantidade")));
            item.setNome_fornecedor(request.getParameter("txt_nome_fornecedor"));

            //Valida se os dados não estão vazios
            if (item.getNome_item().equals("") || item.getValor_item() == 0 || item.getValor_compra() == 0 || item.getNome_fornecedor().equals("")) {
                RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
                request.setAttribute("erro", "Há dados vazios, favor validar!");
                rd.forward(request, response);
            } else {

                dao.Editar(item);

                response.sendRedirect("ListarItem");

            }
        } catch (SQLException e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", "Esse item já existe!");
            rd.forward(request, response);
        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }

    private void excluir(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ClassNotFoundException, SQLException, ServletException {
        try {

            Itens item = new Itens();
            ItemDAO dao = new ItemDAO();
            item.setId(Integer.valueOf(request.getParameter("id")));

            dao.excluir(item);

            response.sendRedirect("ListarItem");

        } catch (Exception e) {
            RequestDispatcher rd = request.getRequestDispatcher("Erro.jsp");
            request.setAttribute("erro", e.toString());
            rd.forward(request, response);
        }
    }
}
