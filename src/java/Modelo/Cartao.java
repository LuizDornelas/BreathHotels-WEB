package Modelo;

/**
 *
 * @author Leticia Possas
 */

public class Cartao {
    private int id;
    private String numerocartao;
    private String nome;
    private String validade;
    private int codigo;
    private String bandeira;
    private boolean cartao_duplicado;

      public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getNumeroCartao() {
        return numerocartao;
    }

    public void setNumeroCartao(String numerocartao) {
        this.numerocartao = numerocartao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getValidade() {
        return validade;
    }

    public void setValidade(String validade) {
        this.validade = validade;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getBandeira() {
        return bandeira;
    }

    public void setBandeira(String bandeira) {
        this.bandeira = bandeira;
    }

    public boolean isCartao_duplicado() {
        return cartao_duplicado;
    }

    public void setCartao_duplicado(boolean cartao_duplicado) {
        this.cartao_duplicado = cartao_duplicado;
    }   
    public Cartao() {
    }
    
}
    

