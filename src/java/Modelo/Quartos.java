package Modelo;

public class Quartos {
    private String quarto;
    private String tipo;
    private int camaSolteiro;
    private int camaCasal;
    private String status;
    private double diaria;
    

    public String getQuarto() {
        return quarto;
    }

    public void setQuarto(String quarto) {
        this.quarto = quarto;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public int getCamaSolteiro() {
        return camaSolteiro;
    }

    public void setCamaSolteiro(int camaSolteiro) {
        this.camaSolteiro = camaSolteiro;
    }

    public int getCamaCasal() {
        return camaCasal;
    }

    public void setCamaCasal(int camaCasal) {
        this.camaCasal = camaCasal;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getDiaria() {
        return diaria;
    }

    public void setDiaria(double diaria) {
        this.diaria = diaria;
    }
    
    public Quartos() {
    }
    
}
