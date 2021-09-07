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
    
    public Usuario autenticaUsuario(Usuario usuario) throws ClassNotFoundException{
        Usuario usuarioAutenticado = null;
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;
        try{
            conexao = ConectaBanco.getConexao();
            pstmt = conexao.prepareStatement(AUTENTICA_USUARIO);
            pstmt.setString(1, usuario.getLogin());
            pstmt.setString(2, usuario.getSenha());
            rsUsuario = pstmt.executeQuery();
            if (rsUsuario.next()){
                usuarioAutenticado = new Usuario();
                usuarioAutenticado.setLogin(rsUsuario.getString("login"));
                usuarioAutenticado.setLogin(rsUsuario.getString("senha"));
                usuarioAutenticado.setTipo(EnumTipoAcesso.valueOf(rsUsuario.getString("tipo")));                
            }
        } catch (SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        } finally {
            if (conexao != null){
                try{
                    conexao.close();
                }catch (SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }
        return usuarioAutenticado;
    }    
}
