/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Conexao.ConectaBanco;
import Modelo.Relatorio;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author luiz.dornelas
 */
public class RelatorioDAO {
    public List<Relatorio> getReservaPorMes() throws ClassNotFoundException, SQLException {

        List<Relatorio> reservaMes;

        try (Connection con = ConectaBanco.getConexao()) {
            PreparedStatement comando = con.prepareStatement("SELECT COUNT(reservaid) AS Quantidade, SUBSTR(entrada,6,2) AS Mes, 'R$ ' || SUM(valor) AS Total FROM reservas GROUP BY Mes ORDER BY Mes");
            ResultSet resultado = comando.executeQuery();
            reservaMes = new ArrayList<>();
            while (resultado.next()) {
                Relatorio v = new Relatorio();
                v.setQuantidade(resultado.getString("quantidade"));
                v.setMes(resultado.getString("mes"));
                v.setTotal(resultado.getString("total"));

                reservaMes.add(v);
            }
        }
        return reservaMes;
    }
}
