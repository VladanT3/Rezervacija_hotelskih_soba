package Models;

public class Korisnik {
    protected String id, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja;

    public Korisnik() {
    }

    public Korisnik(String id, String ime, String prezime, String email, String drzava, String grad, String adresa, String brojTelefona, String datumRodjenja) {
        this.id = id;
        this.ime = ime;
        this.prezime = prezime;
        this.email = email;
        this.drzava = drzava;
        this.grad = grad;
        this.adresa = adresa;
        this.brojTelefona = brojTelefona;
        this.datumRodjenja = datumRodjenja;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIme() {
        return ime;
    }

    public void setIme(String ime) {
        this.ime = ime;
    }

    public String getPrezime() {
        return prezime;
    }

    public void setPrezime(String prezime) {
        this.prezime = prezime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getAdresa() {
        return adresa;
    }

    public void setAdresa(String adresa) {
        this.adresa = adresa;
    }

    public String getBrojTelefona() {
        return brojTelefona;
    }

    public void setBrojTelefona(String brojTelefona) {
        this.brojTelefona = brojTelefona;
    }

    public String getDatumRodjenja() {
        return datumRodjenja;
    }

    public void setDatumRodjenja(String datumRodjenja) {
        this.datumRodjenja = datumRodjenja;
    }
}
