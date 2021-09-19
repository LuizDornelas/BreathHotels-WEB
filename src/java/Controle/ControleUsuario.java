/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controle;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Modelo.Usuario;
import DAO.UsuarioDAO;
import Modelo.EnumTipoAcesso;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author Luiz Dornelas
 */
@WebServlet(name = "ControleUsuario", urlPatterns = {
    "/CadastroUsuario",
    "/ListarUsuario"})

public class ControleUsuario extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String uri = request.getRequestURI();

            if (uri.equals(request.getContextPath() + "/ListarUsuario")) {
                listar(request, response);
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

            if (uri.equals(request.getContextPath() + "/CadastroUsuario")) {
                cadastrar(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Erro.jsp");
        }
    }
    
    private void cadastrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        
        response.setContentType("text/html;charset=UTF-8");
        try {
            String acao = request.getParameter("acao");
            if (acao.equals("Cadastrar")) {
                //Ao clicar em cadastrar no CadUser ele trará até esse servlet
                Usuario usuario = new Usuario();
                //Instancia na classe o que foi inserido nas caixas de texto
                usuario.setNome(request.getParameter("txt_nome"));
                usuario.setRg(request.getParameter("txt_rg"));
                usuario.setTelefone(request.getParameter("txt_telefone"));
                usuario.setRua(request.getParameter("txt_rua"));
                usuario.setNumero(request.getParameter("txt_numero"));
                usuario.setBairro(request.getParameter("txt_bairro"));
                usuario.setCidade(request.getParameter("txt_cidade"));
                usuario.setEstado(request.getParameter("txt_estado"));
                usuario.setCep(request.getParameter("txt_cep"));
                usuario.setLogin(request.getParameter("txt_login"));
                usuario.setSenha(request.getParameter("txt_senha"));
                String perfil = request.getParameter("cmb_tipo");
                if (perfil.equalsIgnoreCase("Admin")) {
                    usuario.setTipo(EnumTipoAcesso.Admin);
                } else if (perfil.equalsIgnoreCase("Func")) {
                    usuario.setTipo(EnumTipoAcesso.Func);
                } else {
                    usuario.setTipo(EnumTipoAcesso.Cliente);
                }
                //Valida se os dados não estão vazios
                if (usuario.getNome().equals("") || usuario.getRg().equals("") || usuario.getTelefone().equals("") || usuario.getRua().equals("") || usuario.getNumero().equals("") || usuario.getBairro().equals("") || usuario.getCidade().equals("") || usuario.getEstado().equals("") || usuario.getCep().equals("") || usuario.getLogin().equals("") || usuario.getSenha().equals("")) {
                    RequestDispatcher rd = request.getRequestDispatcher("CadUser.jsp");
                    request.setAttribute("msg", "Há dados vazios, favor validar!");
                    rd.forward(request, response);
                } else {

                    UsuarioDAO usuarioDAO = new UsuarioDAO();
                    //Instancia uma DAO e leva os dados até o método
                    usuarioDAO.cadastraNovoUsuario(usuario);

                    if (usuario.isLogin_duplicado()) {
                        RequestDispatcher rd = request.getRequestDispatcher("CadUser.jsp");
                        request.setAttribute("msg", "Este Login já existe!");
                        rd.forward(request, response);
                    } else {
                        RequestDispatcher rd = request.getRequestDispatcher("CadUser.jsp");
                        request.setAttribute("msg", "Usuario cadastrado com sucesso!");                        
                        rd.forward(request, response);
                    }
                }
            }
        } catch (NullPointerException erro) {
            RequestDispatcher rd = request.getRequestDispatcher("CadUser.jsp");
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
        
        UsuarioDAO dao = new UsuarioDAO();
        
        List<Usuario> todosUsuarios = dao.consultarTodos();
        
        request.setAttribute("todosUsuarios", todosUsuarios);
        
        request.getRequestDispatcher("ListUsers.jsp").forward(request, response);
    }
}
