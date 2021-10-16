/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author luiz.dornelas
 */
public class Relatorio {

    public String quantidade;
    public String mes;
    public String total;

    public Relatorio() {
    }

    public Relatorio(String quantidade, String mes, String total) {
        this.quantidade = quantidade;
        this.mes = mes;
        this.total = total;
    }

    public String getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(String quantidade) {
        this.quantidade = quantidade;
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
}
