package DAO;

import Conexao.ConectaBanco;
import Modelo.EnumAtivo;
import Modelo.Reserva;
import Modelo.Usuario;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
            Date date = resultado.getDate("entrada");
            SimpleDateFormat formata = new SimpleDateFormat("dd/MM/yyyy");
            String data = formata.format(date);            
            reserva.setEntrada(data);
            reserva.setValor(resultado.getDouble("valor"));
            reserva.setQuarto(resultado.getString("quartofk"));
            reservas.add(reserva);
        }
        con.close();
        return reservas;

    }
}
