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

/**
 *
 * @author patri
 */
public class QuartoDAO {

    private static final String CADASTRA_NOVO_QUARTO = "INSERT INTO public.quartos(quarto, tipo, camasolteiro, camacasal, status, diaria) VALUES (?,?,?,?,'Disponível',?);";
    private static final String ATUALIZA_QUARTO = "select usuarioid, nome, rg, telefone, rua, numero, bairro, cidade, estado, cep, login, senha, tipo, ativo from usuario, login where usuarioid = fk_usuario order by usuarioid;";

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
}
