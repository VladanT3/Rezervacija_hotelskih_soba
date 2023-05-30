package Models;

public class Radnik extends Korisnik{
    protected String datumZaposlenja;

    public Radnik() {
    }

    public Radnik(String id, String ime, String prezime, String email, String drzava, String grad, String adresa, String brojTelefona, String datumRodjenja, String datumZaposlenja) {
        super(id, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja);
        this.datumZaposlenja = datumZaposlenja;
    }

    public String getDatumZaposlenja() {
        return datumZaposlenja;
    }

    public void setDatumZaposlenja(String datumZaposlenja) {
        this.datumZaposlenja = datumZaposlenja;
    }
}
