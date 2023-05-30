package Models;

public class Hotel {
    protected String id, menadzerId, naziv, drzava, grad, opis;
    protected int brojZvezdica, brojParkingMesta;

    public Hotel() {
    }

    public Hotel(String id, String menadzerId, String naziv, String drzava, String grad, String opis, int brojZvezdica, int brojParkingMesta) {
        this.id = id;
        this.menadzerId = menadzerId;
        this.naziv = naziv;
        this.drzava = drzava;
        this.grad = grad;
        this.opis = opis;
        this.brojZvezdica = brojZvezdica;
        this.brojParkingMesta = brojParkingMesta;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMenadzerId() {
        return menadzerId;
    }

    public void setMenadzerId(String menadzerId) {
        this.menadzerId = menadzerId;
    }

    public String getNaziv() {
        return naziv;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public String getDrzava() {
        return drzava;
    }

    public void setDrzava(String drzava) {
        this.drzava = drzava;
    }

    public String getGrad() {
        return grad;
    }

    public void setGrad(String grad) {
        this.grad = grad;
    }

    public String getOpis() {
        return opis;
    }

    public void setOpis(String opis) {
        this.opis = opis;
    }

    public int getBrojZvezdica() {
        return brojZvezdica;
    }

    public void setBrojZvezdica(int brojZvezdica) {
        this.brojZvezdica = brojZvezdica;
    }

    public int getBrojParkingMesta() {
        return brojParkingMesta;
    }

    public void setBrojParkingMesta(int brojParkingMesta) {
        this.brojParkingMesta = brojParkingMesta;
    }
}
