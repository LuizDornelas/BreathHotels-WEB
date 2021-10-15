package DAO;

import Conexao.ConectaBanco;
import Modelo.Cartao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Leticia Possas
 */
public class CartaoDAO {
    
    private static final String CADASTRA_NOVO_CARTAO = "INSERT INTO public.cartao(numerocartao, nome, validade, codigo, bandeira) VALUES (?,?,?,?,?);";
    private static final String CONSULTA_CARTAO = "select numerocartao, nome, validade, codigo, bandeira from cartao";

    public void cadastraNovoCartao(Cartao cartao) throws ClassNotFoundException {

        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsCartao = null;

        try {
            //Conecta com o banco
            conexao = ConectaBanco.getConexao();

            pstmt = conexao.prepareStatement("select count(cartaoid) from cartao where numerocartao=?;");
            pstmt.setString(1, cartao.getNome());
            rsCartao= pstmt.executeQuery();
            rsCartao.next();

            int qntCartao = Integer.parseInt(rsCartao.getString("count"));

            rsCartao.close();

            if (qntCartao == 0) {
                pstmt = conexao.prepareStatement(CADASTRA_NOVO_CARTAO);
                pstmt.setString(1, cartao.getNumeroCartao());
                pstmt.setString(2, cartao.getNome());
                pstmt.setString(3, cartao.getValidade());
                pstmt.setInt(4, cartao.getCodigo());
                pstmt.setString(5, cartao.getBandeira());
                 pstmt.execute();    
                    } else {
                        cartao.setCartao_duplicado(true);
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
    }
      public List<Cartao> consultarTodos() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_CARTAO);
        ResultSet resultado = comando.executeQuery();

        List<Cartao> todosCartao = new ArrayList<Cartao>();
        while (resultado.next()) {
            Cartao cartao = new Cartao();
            
             //cartao.setId(resultado.getInt("cartaoid"));
             cartao.setNumeroCartao(resultado.getString("numerocartao"));
             cartao.setNome(resultado.getString("nome"));
             cartao.setValidade(resultado.getString("validade"));
             cartao.setCodigo(resultado.getInt("codigo"));
             cartao.setBandeira(resultado.getString("bandeira"));
                                          
            todosCartao.add(cartao);
        }
        con.close();
        return todosCartao;
    }
      
}