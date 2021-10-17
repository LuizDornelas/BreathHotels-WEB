package DAO;

import Conexao.ConectaBanco;
import Modelo.Consumo;
import Modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import static java.time.temporal.ChronoUnit.DAYS;
import java.util.ArrayList;
import java.util.List;

public class CheckoutDAO {

    private static final String CONSULTA_RESERVAS = "select reservaid, nomecli, quarto from reservas, quartos where reservas.status = 'Em andamento' and quartofk = id_quarto order by reservaid;";
    private static final String CONSULTA_RESERVA = "select nomecli, entrada, saida, quarto, diaria from reservas, quartos where reservas.status = 'Em andamento' and quartofk = id_quarto and reservaid=?;";
    private static final String CONSULTA_TOTAL_CONSUMO = "SELECT SUM (valor * quantidade) AS total FROM consumos where reservafk=?;";
    private static final String CONSULTA_CONSUMO = "select item, valor, quantidade, data from consumos where reservafk=?;";

    public List<Usuario> consultarReservas() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();
        PreparedStatement comando;

        comando = con.prepareStatement(CONSULTA_RESERVAS);

        ResultSet resultado = comando.executeQuery();

        List<Usuario> todosUsuarios = new ArrayList<>();
        while (resultado.next()) {
            Usuario user = new Usuario();

            user.setId(resultado.getInt("reservaid"));
            user.setNome(resultado.getString("nomecli"));
            user.setQuarto(resultado.getString("quarto"));

            todosUsuarios.add(user);
        }
        con.close();
        return todosUsuarios;
    }

    public void consultarporReserva(Usuario user) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement(CONSULTA_RESERVA);
        com.setInt(1, user.getId());
        ResultSet resultado = com.executeQuery();

        if (resultado.next()) {
            user.setNome(resultado.getString("nomecli"));
            user.setEntrada(resultado.getString("entrada"));
            user.setSaida(resultado.getString("saida"));
            user.setQuarto(resultado.getString("quarto"));

            double diaria = Double.parseDouble(resultado.getString("diaria"));

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

            String parameter = user.getEntrada();

            LocalDateTime entrada = LocalDateTime.parse(parameter, formatter);
            
            LocalDateTime hoje = LocalDateTime.now();

            int countDias = hoje.getDayOfMonth() - entrada.getDayOfMonth();

            if (countDias != 0) {
                diaria *= countDias;
            }

            resultado.close();

            com = con.prepareStatement(CONSULTA_TOTAL_CONSUMO);
            com.setInt(1, user.getId());
            resultado = com.executeQuery();
            resultado.next();

            if (resultado.getString("total") != null) {
                double consumo = (Double.parseDouble(resultado.getString("total")));
                diaria += consumo;
            }
            user.setDiaria(diaria);
        }
    }

    public List<Consumo> consultarConsumo(Usuario user) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();
        PreparedStatement comando;

        comando = con.prepareStatement(CONSULTA_CONSUMO);
        comando.setInt(1, user.getId());
        ResultSet resultado = comando.executeQuery();

        List<Consumo> consumos = new ArrayList<>();
        while (resultado.next()) {
            Consumo consumo = new Consumo();
            consumo.setItem(resultado.getString("item"));
            consumo.setValor(resultado.getDouble("valor"));
            consumo.setQuantidade(resultado.getInt("quantidade"));
            consumo.setData(resultado.getString("data"));
            consumos.add(consumo);
        }
        con.close();
        return consumos;
    }
}
