package Modelo;

public class Usuario {

    private String login;
    private String senha;
    private EnumTipoAcesso tipo;

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

    public EnumTipoAcesso getTipo() {
        return tipo;
    }

    public void setTipo(EnumTipoAcesso tipo) {
        this.tipo = tipo;
    }

    public Usuario() {
    }

    public Usuario(String login, String senha, EnumTipoAcesso tipo) {
        this.login = login;
        this.senha = senha;
        this.tipo = tipo;
    }
}
