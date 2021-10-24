package Modelo;

/**
 *
 * @author Leticia Possas
 */
public class Cartao {

    private int id;
    private int id_cliente;
    private String numero;
    private String nome;
    private String nome_cliente;
    private String validade;
    private int codigo;
    private String bandeira;
    private boolean cartao_duplicado;
    private boolean user_cartao_duplicado;
    private boolean sem_cartao;

    public boolean isSem_cartao() {
        return sem_cartao;
    }

    public void setSem_cartao(boolean valida_cartao) {
        this.sem_cartao = valida_cartao;
    }        
    
    public boolean isUser_cartao_duplicado() {
        return user_cartao_duplicado;
    }

    public void setUser_cartao_duplicado(boolean User_cartao_duplicado) {
        this.user_cartao_duplicado = User_cartao_duplicado;
    }        
    
    public String getNome_cliente() {
        return nome_cliente;
    }

    public void setNome_cliente(String nome_cliente) {
        this.nome_cliente = nome_cliente;
    }   
    
    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
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
