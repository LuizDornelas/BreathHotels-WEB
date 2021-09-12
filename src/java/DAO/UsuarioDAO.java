package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Conexao.ConectaBanco;
import Modelo.Usuario;
import Modelo.EnumTipoAcesso;

public class UsuarioDAO {

    private static final String AUTENTICA_USUARIO = "SELECT login, senha, tipo FROM login WHERE login=? AND senha=? AND ativo='SIM';";
    private static final String CADASTRA_NOVO_USUARIO = "INSERT INTO public.usuario(usuarioid, nome, rg, telefone, rua, numero, bairro, cidade, estado, cep, ativo) VALUES (?,?,?,?,?,?,?,?,?,?,'SIM');";
    private static final String CADASTRA_NOVO_LOGIN = "INSERT INTO public.login(loginid, login, senha, ativo, tipo, fk_usuario) VALUES (?,?,?,'SIM',?,?);";

    //Trás a classe instanciada como parametro no servlet
    public Usuario autenticaUsuario(Usuario usuario) throws ClassNotFoundException {
        Usuario usuarioAutenticado = null;
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;
        try {
            //Conexão com o banco através da querry autentica usuario
            conexao = ConectaBanco.getConexao();
            pstmt = conexao.prepareStatement(AUTENTICA_USUARIO);
            //Insere na querry o login e senha inseridos nas caixas de texto
            pstmt.setString(1, usuario.getLogin());
            pstmt.setString(2, usuario.getSenha());
            rsUsuario = pstmt.executeQuery();
            if (rsUsuario.next()) {
                //Virá até essa etapa se o login e senha forem bem sucedidos conforme o que consta no banco
                usuarioAutenticado = new Usuario();
                usuarioAutenticado.setLogin(rsUsuario.getString("login"));
                usuarioAutenticado.setSenha(rsUsuario.getString("senha"));
                usuarioAutenticado.setTipo(EnumTipoAcesso.valueOf(rsUsuario.getString("tipo")));
            }
        } catch (SQLException sqlErro) {
            throw new RuntimeException(sqlErro);
        } finally {
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }
            }
        }
        return usuarioAutenticado;
    }

    public void cadastraNovoUsuario(Usuario usuario) throws ClassNotFoundException {

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;

        try {
            //Conecta com o banco
            con = ConectaBanco.getConexao();
            pstmt = con.prepareStatement("select count(usuarioid) from usuario;");
            rsUsuario = pstmt.executeQuery();
            rsUsuario.next();
            //A querry acima conta quantos usuários tem criados para ter o próximo número de id do usuário que será criado
            int id_num = Integer.parseInt(rsUsuario.getString("count"));

            id_num += 1;
            
            rsUsuario.close();
            
            //Essa querry irá validar se há um login com o mesmo nome do inserido
            pstmt = con.prepareStatement("select count(login) from login where login=?;");                                    
            pstmt.setString(1, usuario.getLogin());
            rsUsuario = pstmt.executeQuery();
            rsUsuario.next();
            
            int qntLogin = Integer.parseInt(rsUsuario.getString("count"));
            
            rsUsuario.close();
            
            if(qntLogin == 0){
                //Se não houver login igual irá cadastrar na tabela usuário e login conforme parametros
                pstmt = con.prepareStatement(CADASTRA_NOVO_USUARIO);                                    
                pstmt.setInt(1, id_num);
                pstmt.setString(2, usuario.getNome());
                pstmt.setString(3, usuario.getRg());
                pstmt.setString(4, usuario.getTelefone());
                pstmt.setString(5, usuario.getRua());
                pstmt.setString(6, usuario.getNumero());
                pstmt.setString(7, usuario.getBairro());
                pstmt.setString(8, usuario.getCidade());
                pstmt.setString(9, usuario.getEstado());
                pstmt.setString(10, usuario.getCep());
                pstmt.execute();
                pstmt.close();
                
                pstmt = con.prepareStatement(CADASTRA_NOVO_LOGIN);
                pstmt.setInt(1, id_num);
                pstmt.setString(2, usuario.getLogin());
                pstmt.setString(3, usuario.getSenha());
                pstmt.setString(4, usuario.getTipo().toString());
                pstmt.setInt(5, id_num);
                pstmt.execute();
            } else{
                //Caso haja login igual irá instanciar atributo como true para mostrar que há login duplicado no front
                usuario.setLogin_duplicado(true);
            }           
             
        } catch (SQLException sqlErro) {
            throw new RuntimeException(sqlErro);
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }

            }
        }

    }
}
