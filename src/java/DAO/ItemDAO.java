package DAO;

import Conexao.ConectaBanco;
import Modelo.EnumStatus;
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

    private static final String CADASTRA_ITEM = "INSERT INTO public.itens(item, valor, quantidade, status) VALUES (?, ?, ?, ?);";
    private static final String CADASTRA_FORNECEDOR = "INSERT INTO fornecedor(nome_fornecedor, valor_item, itemfk) VALUES (?, ?, ?);";
    private static final String CONSULTA_ITEM = "select itemid, item, valor, status, quantidade, nome_fornecedor, valor_item from itens, fornecedor where itemfk = itemid order by itemid;";
    private static final String CONSULTA_ITEM_DISPONIVEIS = "select itemid, item, valor, status, quantidade, nome_fornecedor, valor_item from itens, fornecedor where itemfk = itemid and quantidade > 0 order by itemid;";

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
                //Se não houver item igual irá cadastrar na tabela itens e fornecedor conforme parametros
                pstmt = con.prepareStatement(CADASTRA_ITEM);
                pstmt.setString(1, item.getNome_item());
                pstmt.setDouble(2, item.getValor_item());
                pstmt.setInt(3, item.getQuantidade());
                if (item.getQuantidade() == 0) {
                    pstmt.setString(4, "Indisponivel");
                } else {
                    pstmt.setString(4, "Disponivel");
                }
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
            item.setStatus((EnumStatus.valueOf(resultado.getString("status"))));
            item.setNome_fornecedor(resultado.getString("nome_fornecedor"));
            item.setValor_compra(resultado.getDouble("valor_item"));

            todosItens.add(item);
        }
        con.close();
        return todosItens;
    }

    public List<Itens> consultarDisponiveis() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_ITEM_DISPONIVEIS);
        ResultSet resultado = comando.executeQuery();

        List<Itens> todosItens = new ArrayList<Itens>();
        while (resultado.next()) {
            Itens item = new Itens();

            item.setId(resultado.getInt("itemid"));
            item.setNome_item(resultado.getString("item"));
            item.setValor_item(resultado.getDouble("valor"));
            item.setQuantidade(resultado.getInt("quantidade"));
            item.setStatus((EnumStatus.valueOf(resultado.getString("status"))));
            item.setNome_fornecedor(resultado.getString("nome_fornecedor"));
            item.setValor_compra(resultado.getDouble("valor_item"));

            todosItens.add(item);
        }
        con.close();
        return todosItens;

    }

    public void consultarporId(Itens item) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("select itemid, item, valor, status, quantidade, nome_fornecedor, valor_item from itens, fornecedor where itemfk = itemid and itemid=?;");
        com.setInt(1, item.getId());
        ResultSet resultado = com.executeQuery();

        if (resultado.next()) {
            item.setId(resultado.getInt("itemid"));
            item.setNome_item(resultado.getString("item"));
            item.setValor_item(resultado.getDouble("valor"));
            item.setQuantidade(resultado.getInt("quantidade"));
            item.setStatus((EnumStatus.valueOf(resultado.getString("status"))));
            item.setNome_fornecedor(resultado.getString("nome_fornecedor"));
            item.setValor_compra(resultado.getDouble("valor_item"));
        }
    }

    public void comprarItem(Itens item) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("select item, quantidade, valor from itens where itemid=?;");
        com.setInt(1, item.getId());
        ResultSet resultado = com.executeQuery();
        resultado.next();
        int quantidade = Integer.parseInt(resultado.getString("quantidade"));
        String nome = resultado.getString("item");
        double valor = Double.parseDouble(resultado.getString("valor"));
        resultado.close();

        if (item.getQuantidade() > quantidade) {
            item.setItem_valicacao(true);
        } else {
            com = con.prepareStatement("INSERT INTO consumos(item, valor, quantidade, reservafk, itemfk) VALUES(?,?,?,?,?);");
            com.setString(1, nome);
            com.setDouble(2, valor);
            com.setInt(3, item.getQuantidade());
            com.setInt(4, item.getId_quarto());
            com.setInt(5, item.getId());
            com.execute();
            com.close();

            com = con.prepareStatement("UPDATE itens set quantidade =? WHERE itemid=?;");
            quantidade -= item.getQuantidade();
            com.setInt(1, quantidade);
            com.setInt(2, item.getId());
            com.execute();
            com.close();

            if (quantidade == 0) {
                com = con.prepareStatement("UPDATE itens set status = 'Indisponível' WHERE itemid=?;");
                com.setInt(1, item.getId());
                com.execute();
            }
        }
    }

    public void Editar(Itens item) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;

        //Conecta com o banco
        con = ConectaBanco.getConexao();

        //Se não houver item igual irá atualizar na tabela itens e fornecedor conforme parametros
        pstmt = con.prepareStatement("UPDATE public.itens SET item=?, valor=?, quantidade=?, status=? WHERE itemid=?;");
        pstmt.setString(1, item.getNome_item());
        pstmt.setDouble(2, item.getValor_item());
        pstmt.setInt(3, item.getQuantidade());
        if (item.getQuantidade() == 0) {
            pstmt.setString(4, "Indisponível");
        } else {
            pstmt.setString(4, "Disponivel");
        }
        pstmt.setInt(5, item.getId());
        pstmt.execute();
        pstmt.close();

        //atualiza na tabela fornecedor
        pstmt = con.prepareStatement("UPDATE public.fornecedor SET nome_fornecedor=?, valor_item=? WHERE itemfk=?;");
        pstmt.setString(1, item.getNome_fornecedor());
        pstmt.setDouble(2, item.getValor_compra());
        pstmt.setInt(3, item.getId());
        pstmt.execute();

    }

    public void excluir(Itens item) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("DELETE FROM public.fornecedor WHERE itemfk=?;");
        com.setInt(1, item.getId());
        com.execute();
        com.close();

        com = con.prepareStatement("DELETE FROM public.itens WHERE itemid=?;");
        com.setInt(1, item.getId());
        com.execute();
    }
}
