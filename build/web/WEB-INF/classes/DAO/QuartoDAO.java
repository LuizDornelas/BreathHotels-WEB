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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author patri
 */
public class QuartoDAO {

    private static final String CADASTRA_NOVO_QUARTO = "INSERT INTO public.quartos(quarto, tipo, camasolteiro, camacasal, status, diaria) VALUES (?,?,?,?,'Disponível',?);";
    private static final String CONSULTA_QUARTO = "select quarto, tipo, camasolteiro, camacasal, status,diaria from quartos";

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
            
            if (qntQuarto == 0){
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
}