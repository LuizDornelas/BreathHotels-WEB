package Modelo;


public class Itens {
    private int id;
    private int id_quarto;
    private String nome_item;
    private double valor_item;
    private int quantidade;
    private String nome_fornecedor;
    private double valor_compra;
    private EnumStatus status;
    private boolean item_duplicado;
    private boolean item_valicacao;

    public int getId_quarto() {
        return id_quarto;
    }

    public void setId_quarto(int id_quarto) {
        this.id_quarto = id_quarto;
    }

    public boolean isItem_valicacao() {
        return item_valicacao;
    }

    public void setItem_valicacao(boolean item_valicacao) {
        this.item_valicacao = item_valicacao;
    }

    public String getNome_item() {
        return nome_item;
    }

    public void setNome_item(String nome_item) {
        this.nome_item = nome_item;
    }

    public double getValor_item() {
        return valor_item;
    }

    public void setValor_item(double valor_item) {
        this.valor_item = valor_item;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public String getNome_fornecedor() {
        return nome_fornecedor;
    }

    public void setNome_fornecedor(String nome_fornecedor) {
        this.nome_fornecedor = nome_fornecedor;
    }

    public double getValor_compra() {
        return valor_compra;
    }

    public void setValor_compra(double valor_compra) {
        this.valor_compra = valor_compra;
    }
    
    public boolean isItem_duplicado() {
        return item_duplicado;
    }

    public void setItem_duplicado(boolean item_duplicado) {
        this.item_duplicado = item_duplicado;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public EnumStatus getStatus() {
        return status;
    }

    public void setStatus(EnumStatus status) {
        this.status = status;
    }    
                
    public Itens() {
    }
        
}
