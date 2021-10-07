package Modelo;

/**
 *
 * @author Leticia Possas
 */
public class Cartao {
 private int numerocartao;
    private String nome;
    private int validade;
    private int codigo;
    private String bandeira;
    private boolean cartao_duplicado;

    public int getNumeroCartao() {
        return numerocartao;
    }

    public void setNumeroCartao(int numerocartao) {
        this.numerocartao = numerocartao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getValidade() {
        return validade;
    }

    public void setValidade(int validade) {
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
    

