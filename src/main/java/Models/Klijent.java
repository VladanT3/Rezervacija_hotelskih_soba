package Models;

public class Klijent extends Korisnik{
    protected int brojPoena;

    public Klijent() {
    }

    public Klijent(String id, String ime, String prezime, String email, String drzava, String grad, String adresa, String brojTelefona, String datumRodjenja, int brojPoena) {
        super(id, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja);
        this.brojPoena = brojPoena;
    }

    public int getBrojPoena() {
        return brojPoena;
    }

    public void setBrojPoena(int brojPoena) {
        this.brojPoena = brojPoena;
    }
}
