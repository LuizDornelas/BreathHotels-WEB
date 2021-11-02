package DAO;

import Conexao.ConectaBanco;
import Modelo.Historico;
import Modelo.Reserva;
import Modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HistoricoDAO {

    private static final String CONSULTA_RESERVAS = "select reservaid, quarto, nome, entrada, saida, valor, nomefunc  from reservas r, quartos q, usuario u where r.status = 'Encerrado' and quartofk = id_quarto and usuariofk = usuarioid order by reservaid;";
    private static final String CONSULTA_CONSUMOS = "select reservafk, item, valor, quantidade, data from consumos order by reservafk;";
    private static final String CONSULTA_RESERVAS_ENCERRADAS = "select reservaid, nomefunc, entrada, saida, valor, quarto from reservas, quartos where reservas.status = 'Encerrado' and quartofk = id_quarto and usuariofk=? order by reservaid;";
    private static final String CONSULTA_CONSUMOS_CLIENTE = "select reservafk, item, consumos.valor, quantidade, data from consumos, reservas where reservafk = reservaid and usuariofk=? order by reservafk;";
    
    public List<Historico> consultarReservas() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();
        PreparedStatement comando;
        comando = con.prepareStatement(CONSULTA_RESERVAS);

        ResultSet resultado = comando.executeQuery();

        List<Historico> todasReservas = new ArrayList<>();
        while (resultado.next()) {
            Historico reserva = new Historico();

            reserva.setReserva(resultado.getInt("reservaid"));
            reserva.setQuarto(resultado.getString("quarto"));
            reserva.setNome(resultado.getString("nome"));
            reserva.setEntrada(resultado.getString("entrada"));
            reserva.setSaida(resultado.getString("saida"));
            reserva.setValor(resultado.getDouble("valor"));            
            reserva.setFuncionario(resultado.getString("nomefunc"));
            
            todasReservas.add(reserva);
        }
        con.close();
        return todasReservas;

    }
    
    public List<Historico> consultarConsumos() throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();
        PreparedStatement comando;
        comando = con.prepareStatement(CONSULTA_CONSUMOS);

        ResultSet resultado = comando.executeQuery();

        List<Historico> todasConsumos = new ArrayList<>();
        while (resultado.next()) {
            Historico consumo = new Historico();

            consumo.setReserva(resultado.getInt("reservafk"));
            consumo.setItem(resultado.getString("item"));
            consumo.setValor(resultado.getDouble("valor"));
            consumo.setQuantidade(resultado.getInt("quantidade"));
            consumo.setData(resultado.getString("data"));            
            
            todasConsumos.add(consumo);
        }
        con.close();
        return todasConsumos;

    }
    public List<Historico> consultarConsumosCliente(Usuario user) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();
        PreparedStatement comando;
        
        comando = con.prepareStatement("select fk_usuario from login where login=?;");
        comando.setString(1, user.getLogin());
        ResultSet resultado = comando.executeQuery();
        resultado.next();

        int id = Integer.parseInt(resultado.getString("fk_usuario"));

        resultado.close();                
        
        comando = con.prepareStatement(CONSULTA_CONSUMOS_CLIENTE);
        comando.setInt(1, id);
        resultado = comando.executeQuery();

        List<Historico> todasConsumos = new ArrayList<>();
        while (resultado.next()) {
            Historico consumo = new Historico();

            consumo.setReserva(resultado.getInt("reservafk"));
            consumo.setItem(resultado.getString("item"));
            consumo.setValor(resultado.getDouble("valor"));
            consumo.setQuantidade(resultado.getInt("quantidade"));
            consumo.setData(resultado.getString("data"));            
            
            todasConsumos.add(consumo);
        }
        con.close();
        return todasConsumos;

    }
    
    public List<Reserva> consultarReservasEncerradas(Usuario user) throws ClassNotFoundException, SQLException {

        Connection con = ConectaBanco.getConexao();
        PreparedStatement comando;
        
        comando = con.prepareStatement("select fk_usuario from login where login=?;");
        comando.setString(1, user.getLogin());
        ResultSet resultado = comando.executeQuery();
        resultado.next();

        int id = Integer.parseInt(resultado.getString("fk_usuario"));

        resultado.close();
        
        comando = con.prepareStatement(CONSULTA_RESERVAS_ENCERRADAS);
        comando.setInt(1, id);
        resultado = comando.executeQuery();

        List<Reserva> reservas = new ArrayList<>();
        while (resultado.next()) {
            Reserva reserva = new Reserva();
            reserva.setNumreserva(Integer.parseInt(resultado.getString("reservaid")));
            reserva.setNomeFuncionario(resultado.getString("nomefunc"));                       
            reserva.setEntrada(resultado.getString("entrada"));
            reserva.setSaida(resultado.getString("saida"));
            reserva.setValor(resultado.getDouble("valor"));
            reserva.setQuarto(resultado.getString("quarto"));
            reservas.add(reserva);
        }
        con.close();
        return reservas;

    }
}
