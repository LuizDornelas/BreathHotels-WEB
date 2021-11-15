/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Conexao.ConectaBanco;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Modelo.Quartos;
import Modelo.Usuario;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author patri
 */
public class QuartoDAO {

    private static final String CADASTRA_NOVO_QUARTO = "INSERT INTO public.quartos(quarto, tipo, camasolteiro, camacasal, status, diaria) VALUES (?,?,?,?,'Disponível',?);";
    private static final String CONSULTA_QUARTO = "select id_quarto, quarto, tipo, camasolteiro, camacasal, status, diaria from quartos order by id_quarto";
    private static final String CONSULTA_DISPONIVEIS = "select id_quarto, quarto, camasolteiro, camacasal, diaria from quartos where status = 'Disponível' order by quarto";
    private static final String CONSULTA_RESERVAS = "select reservafk, quarto, camasolteiro, camacasal, diaria, nomecli from quartos, reservas where quartos.status = 'Ocupado' and reservas.status = 'Em andamento' and reservafk = reservaid order by quarto;";
    private static final String CONSULTA_RESERVAS_CLIENTE = "select reservafk, quarto, camasolteiro, camacasal, diaria, nomecli from quartos, reservas where quartos.status = 'Ocupado' and reservas.status = 'Em andamento' and reservafk = reservaid and usuariofk=? order by quarto;";

    public void cadastraNovoQuarto(Quartos quartos) throws ClassNotFoundException, SQLException {

        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsQuarto = null;
        try {
            //Conecta com o banco
            conexao = ConectaBanco.getConexao();
            pstmt = conexao.prepareStatement("select count(quarto) from quartos where quarto=?;");
            pstmt.setString(1, quartos.getQuarto());
            rsQuarto = pstmt.executeQuery();
            rsQuarto.next();

            int qntQuarto = Integer.parseInt(rsQuarto.getString("count"));

            rsQuarto.close();

            if (qntQuarto == 0) {
                pstmt = conexao.prepareStatement(CADASTRA_NOVO_QUARTO);
                pstmt.setString(1, quartos.getQuarto());
                pstmt.setString(2, quartos.getTipo());
                pstmt.setInt(3, quartos.getCamaSolteiro());
                pstmt.setInt(4, quartos.getCamaCasal());
                pstmt.setDouble(5, quartos.getDiaria());
                pstmt.execute();
            } else {
                quartos.setQuarto_duplicado(true);
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

    public List<Quartos> consultarTodos() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_QUARTO);
        ResultSet resultado = comando.executeQuery();

        List<Quartos> todosQuartos = new ArrayList<Quartos>();
        while (resultado.next()) {
            Quartos quartos = new Quartos();
            quartos.setId(Integer.parseInt(resultado.getString("id_quarto")));
            quartos.setQuarto(resultado.getString("quarto"));
            quartos.setTipo(resultado.getString("tipo"));
            quartos.setCamaSolteiro(resultado.getInt("camaSolteiro"));
            quartos.setCamaCasal(resultado.getInt("camaCasal"));
            quartos.setStatus(resultado.getString("status"));
            quartos.setDiaria(resultado.getDouble("diaria"));

            todosQuartos.add(quartos);
        }
        con.close();
        return todosQuartos;
    }

    public List<Quartos> consultarDisponiveis() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_DISPONIVEIS);
        ResultSet resultado = comando.executeQuery();

        List<Quartos> todosQuartos = new ArrayList<Quartos>();
        while (resultado.next()) {
            Quartos quartos = new Quartos();
            quartos.setId(Integer.parseInt(resultado.getString("id_quarto")));
            quartos.setQuarto(resultado.getString("quarto"));
            quartos.setCamaSolteiro(resultado.getInt("camaSolteiro"));
            quartos.setCamaCasal(resultado.getInt("camaCasal"));
            quartos.setDiaria(resultado.getDouble("diaria"));

            todosQuartos.add(quartos);
        }
        con.close();
        return todosQuartos;
    }

    public List<Quartos> consultarReservas() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();

        PreparedStatement comando = con.prepareStatement(CONSULTA_RESERVAS);
        ResultSet resultado = comando.executeQuery();

        List<Quartos> todosQuartos = new ArrayList<Quartos>();
        while (resultado.next()) {
            Quartos quartos = new Quartos();
            quartos.setId(Integer.parseInt(resultado.getString("reservafk")));
            quartos.setQuarto(resultado.getString("quarto"));
            quartos.setCamaSolteiro(resultado.getInt("camaSolteiro"));
            quartos.setCamaCasal(resultado.getInt("camaCasal"));
            quartos.setDiaria(resultado.getDouble("diaria"));
            quartos.setNome(resultado.getString("nomecli"));

            todosQuartos.add(quartos);
        }
        con.close();
        return todosQuartos;
    }

    public List<Quartos> consultarReservasCliente(Usuario user) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();
        PreparedStatement comando = null;
        comando = con.prepareStatement("select fk_usuario from login where login=?;");
        comando.setString(1, user.getLogin());
        ResultSet resultado = comando.executeQuery();
        resultado.next();

        int id = Integer.parseInt(resultado.getString("fk_usuario"));

        resultado.close();

        comando = con.prepareStatement(CONSULTA_RESERVAS_CLIENTE);
        comando.setInt(1, id);
        resultado = comando.executeQuery();

        List<Quartos> todosQuartos = new ArrayList<Quartos>();
        while (resultado.next()) {
            Quartos quartos = new Quartos();
            quartos.setId(Integer.parseInt(resultado.getString("reservafk")));
            quartos.setQuarto(resultado.getString("quarto"));
            quartos.setCamaSolteiro(resultado.getInt("camaSolteiro"));
            quartos.setCamaCasal(resultado.getInt("camaCasal"));
            quartos.setDiaria(resultado.getDouble("diaria"));
            quartos.setNome(resultado.getString("nomecli"));

            todosQuartos.add(quartos);
        }
        con.close();
        return todosQuartos;
    }

    public void Editar(Quartos quartos) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;

        //Conecta com o banco
        con = ConectaBanco.getConexao();

        pstmt = con.prepareStatement("UPDATE public.quartos SET quarto=?, tipo=?, camaSolteiro=?, camaCasal=?, diaria=? WHERE id_quarto=?;");
        pstmt.setString(1, quartos.getQuarto());
        pstmt.setString(2, quartos.getTipo());
        pstmt.setInt(3, quartos.getCamaSolteiro());
        pstmt.setInt(4, quartos.getCamaCasal());
        pstmt.setDouble(5, quartos.getDiaria());
        pstmt.setInt(6, quartos.getId());

        pstmt.execute();
        pstmt.close();
    }

    public void excluir(Quartos quartos) throws ClassNotFoundException, SQLException {
        ResultSet rsQuarto = null;
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("select count(id_quarto) from quartos where id_quarto=? and status = 'Ocupado';");
        com.setInt(1, quartos.getId());
        rsQuarto = com.executeQuery();
        rsQuarto.next();
        int countQuarto = Integer.parseInt(rsQuarto.getString("count"));
        rsQuarto.close();
        if (countQuarto > 0) {
            quartos.setQuarto_duplicado(true);
        } else {
            con = ConectaBanco.getConexao();
            com = con.prepareStatement("DELETE FROM public.quartos WHERE id_quarto=?;");
            com.setInt(1, quartos.getId());
            com.execute();
        }
    }

    public void consultarporQuarto(Quartos quarto) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("select quarto, tipo, camasolteiro, camacasal, diaria from quartos where id_quarto=?;");
        com.setInt(1, quarto.getId());
        ResultSet resultado = com.executeQuery();

        if (resultado.next()) {
            quarto.setQuarto(resultado.getString("quarto"));
            quarto.setTipo(resultado.getString("tipo"));
            quarto.setCamaSolteiro(resultado.getInt("camasolteiro"));
            quarto.setCamaCasal(resultado.getInt("camacasal"));
            quarto.setDiaria(resultado.getDouble("diaria"));
        }
    }
}
