package DAO;

import Conexao.ConectaBanco;
import Modelo.Itens;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Luiz Dornelas
 */
public class ItemDAO {

    private static final String CADASTRA_ITEM = "INSERT INTO public.itens(item, valor, quantidade, status) VALUES (?, ?, ?, 'Disponivel');";
    private static final String CADASTRA_FORNECEDOR = "INSERT INTO fornecedor(nome_fornecedor, valor_item, itemfk) VALUES (?, ?, ?);";
    private static final String CONSULTA_ITEM = "select itemid, item, valor, status, quantidade, nome_fornecedor, valor_item from itens, fornecedor where itemfk = itemid order by itemid;";

    public void cadastraNovoItem(Itens item) throws ClassNotFoundException {

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rsItem = null;

        try {
            //Conecta com o banco
            con = ConectaBanco.getConexao();

            //Essa querry irá validar se há um item com o mesmo nome do inserido
            pstmt = con.prepareStatement("select count (itemid) from itens where item=?;");
            pstmt.setString(1, item.getNome_item());
            rsItem = pstmt.executeQuery();
            rsItem.next();

            int qntItem = Integer.parseInt(rsItem.getString("count"));

            rsItem.close();

            if (qntItem == 0) {
                //Se não houver login igual irá cadastrar na tabela itens e fornecedor conforme parametros
                pstmt = con.prepareStatement(CADASTRA_ITEM);
                pstmt.setString(1, item.getNome_item());
                pstmt.setDouble(2, item.getValor_item());
                pstmt.setInt(3, item.getQuantidade());
                pstmt.execute();
                pstmt.close();

                //procura id do item recem cadatrado
                pstmt = con.prepareStatement("select itemid from itens where item=?;");
                pstmt.setString(1, item.getNome_item());
                rsItem = pstmt.executeQuery();
                rsItem.next();

                String id_item = rsItem.getString("itemid");

                rsItem.close();
                
                //cadatra na tabela fornecedor
                pstmt = con.prepareStatement(CADASTRA_FORNECEDOR);
                pstmt.setString(1, item.getNome_fornecedor());
                pstmt.setDouble(2, item.getValor_compra());
                pstmt.setInt(3, Integer.parseInt(id_item));
                pstmt.execute();
            } else {
                //Caso haja item igual irá instanciar atributo como true para mostrar que há login duplicado no front
                item.setItem_duplicado(true);
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
    public List<Itens> consultarTodos() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_ITEM);
        ResultSet resultado = comando.executeQuery();

        List<Itens> todosItens = new ArrayList<Itens>();
        while (resultado.next()) {
            Itens item = new Itens();
            
            item.setId(resultado.getInt("itemid"));
            item.setNome_item(resultado.getString("item"));
            item.setValor_item(resultado.getDouble("valor"));
            item.setQuantidade(resultado.getInt("quantidade"));
            item.setStatus(resultado.getString("status"));
            item.setNome_fornecedor(resultado.getString("nome_fornecedor"));
            item.setValor_compra(resultado.getDouble("valor_item"));                                 

            todosItens.add(item);
        }
        con.close();
        return todosItens;

    }
}
