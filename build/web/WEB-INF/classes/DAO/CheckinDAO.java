package DAO;

import Conexao.ConectaBanco;
import Modelo.Reserva;
import Modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CheckinDAO {

    private static final String CONSULTA_RESERVA = "select nomecli, entrada, valor, quartofk from reservas where status = 'Em andamento' order by reservaid;";

    public List<Reserva> consultarReservas() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();
        PreparedStatement comando;

        comando = con.prepareStatement(CONSULTA_RESERVA);

        ResultSet resultado = comando.executeQuery();

        List<Reserva> reservas = new ArrayList<>();
        while (resultado.next()) {
            Reserva reserva = new Reserva();
            reserva.setNomeCliente(resultado.getString("nomecli"));                       
            reserva.setEntrada(resultado.getString("entrada"));
            reserva.setValor(resultado.getDouble("valor"));
            reserva.setQuarto(resultado.getString("quartofk"));
            reservas.add(reserva);
        }
        con.close();
        return reservas;

    }

    public void cadastrar(Usuario usuario) throws ClassNotFoundException {

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rsDiaria = null;

        try {
            //Conecta com o banco
            con = ConectaBanco.getConexao();
            pstmt = con.prepareStatement("select diaria, nome from quartos, usuario where quarto=? and usuarioid=?;");            
            pstmt.setString(1, usuario.getQuarto());
            pstmt.setInt(2, usuario.getId());
            rsDiaria = pstmt.executeQuery();
            rsDiaria.next();
            //A querry acima retorna o valor da diaria       
            double diaria = rsDiaria.getDouble("diaria");
            usuario.setNome(rsDiaria.getString("nome"));

            rsDiaria.close();

            //Essa querry irá inserir dados na tabela reserva
            pstmt = con.prepareStatement("INSERT INTO reservas(nomefunc, nomecli, entrada, saida, valor, quartofk, status, usuariofk) VALUES(?,?,?,?,?,?,'Em andamento',?);");
            pstmt.setString(1, usuario.getLogin());
            pstmt.setString(2, usuario.getNome());
            pstmt.setString(3, usuario.getEntrada());
            pstmt.setString(4, usuario.getSaida());
            pstmt.setDouble(5, diaria);
            pstmt.setString(6, usuario.getQuarto());
            pstmt.setInt(7, usuario.getId());

            pstmt.execute();
            pstmt.close();

            //Essa querry irá alterar dados da tabela quartoss
            pstmt = con.prepareStatement("UPDATE quartos SET status='Ocupado', reservafk=(select reservaid from reservas where quartofk=? and status = 'Em andamento') WHERE quarto=?;");
            pstmt.setString(1, usuario.getQuarto());
            pstmt.setString(2, usuario.getQuarto());

            pstmt.execute();

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
