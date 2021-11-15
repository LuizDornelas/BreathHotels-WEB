package DAO;

import Conexao.ConectaBanco;
import Modelo.Cartao;
import Modelo.Consumo;
import Modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
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

    public void consultarReservaCartao(Usuario user, Cartao card) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("select usuariofk from reservas where reservaid=?;");
        com.setInt(1, user.getId());
        ResultSet resultado = com.executeQuery();
        resultado.next();

        int id = Integer.parseInt(resultado.getString("usuariofk"));

        resultado.close();

        com = con.prepareStatement("select numerocartao from cartao where usuariofk=?;");
        com.setInt(1, id);
        resultado = com.executeQuery();
        if (resultado.next()) {
            card.setNumero(resultado.getString("numerocartao"));
            com = con.prepareStatement(CONSULTA_RESERVA);
            com.setInt(1, user.getId());
            resultado = com.executeQuery();

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

                long countDias = entrada.until(hoje, ChronoUnit.DAYS);

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
        } else {
            card.setSem_cartao(true);
        }
    }

    public void consultarReservaDinheiro(Usuario user) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("select usuariofk from reservas where reservaid=?;");
        com.setInt(1, user.getId());
        ResultSet resultado = com.executeQuery();
        resultado.next();

        int id = Integer.parseInt(resultado.getString("usuariofk"));

        resultado.close();

        com = con.prepareStatement(CONSULTA_RESERVA);
        com.setInt(1, user.getId());
        resultado = com.executeQuery();

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

            long countDias = entrada.until(hoje, ChronoUnit.DAYS);                     

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

    public void consultarCartao(Usuario user, Cartao card) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("select usuariofk from reservas where reservaid=?;");
        com.setInt(1, user.getId());
        ResultSet resultado = com.executeQuery();
        resultado.next();

        int id = Integer.parseInt(resultado.getString("usuariofk"));

        resultado.close();

        com = con.prepareStatement("select numerocartao from cartao where usuariofk=?;");
        com.setInt(1, id);
        resultado = com.executeQuery();
        if (resultado.next()) {
            card.setNumero(resultado.getString("numerocartao"));
        } else {
            card.setSem_cartao(true);
        }
    }

    public void pagamentoCheckout(Usuario user) throws ClassNotFoundException, SQLException {
        Connection con = ConectaBanco.getConexao();
        PreparedStatement com = con.prepareStatement("select usuariofk, quartofk from reservas where reservaid=?;");
        com.setInt(1, user.getId());
        ResultSet resultado = com.executeQuery();
        resultado.next();

        int id_user = Integer.parseInt(resultado.getString("usuariofk"));
        int id_quarto = Integer.parseInt(resultado.getString("quartofk"));

        resultado.close();
        //Atualiza a tabela reservas para encerrar a reserva do cliente
        com = con.prepareStatement("UPDATE reservas SET status='Encerrado', valor=?, saida=? WHERE usuariofk=? and status= 'Em andamento' and quartofk=?;");
        com.setDouble(1, user.getDiaria());
        com.setString(2, user.getSaida());
        com.setInt(3, id_user);
        com.setInt(4, id_quarto);
        com.execute();
        com.close();

        com = con.prepareStatement("UPDATE quartos SET status='Disponível', reservafk=null WHERE reservafk=?;");
        com.setInt(1, user.getId());
        com.execute();
        com.close();

        com = con.prepareStatement("select count(usuariofk) from reservas where status = 'Em andamento' and usuariofk=?;");
        com.setInt(1, id_user);
        resultado = com.executeQuery();
        resultado.next();

        int reserva_count = Integer.parseInt(resultado.getString("count"));

        resultado.close();

        if (reserva_count == 0) {
            com = con.prepareStatement("UPDATE login SET ativo='NAO' WHERE fk_usuario=?;");
            com.setInt(1, id_user);
            com.execute();
        }
    }
}
