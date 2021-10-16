package Modelo;

import java.util.Date;

public class Usuario {
    
    private int id;
    private int dias;
    private String login;
    private String senha;
    private String confirmasenha;
    private EnumTipoAcesso tipo;
    private EnumAtivo ativo;
    private String nome;
    private String rg;
    private String telefone;
    private String rua;
    private String numero;
    private String bairro;
    private String cidade;
    private String estado;
    private String cep;   
    private boolean login_duplicado;
    private String entrada;
    private String saida;
    private int quarto;
    

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getConfirmasenha() {
        return confirmasenha;
    }

    public void setConfirmasenha(String confirmasenha) {
        this.confirmasenha = confirmasenha;
    }        
    
    public EnumTipoAcesso getTipo() {
        return tipo;
    }

    public void setTipo(EnumTipoAcesso tipo) {
        this.tipo = tipo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getRg() {
        return rg;
    }

    public void setRg(String rg) {
        this.rg = rg;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }


    public EnumAtivo getAtivo() {
        return ativo;
    }

    public void setAtivo(EnumAtivo ativo) {
        this.ativo = ativo;
    }        

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }       

    public boolean isLogin_duplicado() {
        return login_duplicado;
    }

    public void setLogin_duplicado(boolean login_duplicado) {
        this.login_duplicado = login_duplicado;
    }        

    public String getEntrada() {
        return entrada;
    }

    public void setEntrada(String entrada) {
        this.entrada = entrada;
    }

    public String getSaida() {
        return saida;
    }

    public void setSaida(String saida) {
        this.saida = saida;
    }  

    public int getQuarto() {
        return quarto;
    }

    public void setQuarto(int quarto) {
        this.quarto = quarto;
    }    

    public int getDias() {
        return dias;
    }

    public void setDias(int dias) {
        this.dias = dias;
    }
    
    public Usuario() {
    }    
}
