package Models;

public class Menadzer extends Radnik{
    public Menadzer() {
    }

    public Menadzer(String id, String ime, String prezime, String email, String drzava, String grad, String adresa, String brojTelefona, String datumRodjenja, String datumZaposlenja) {
        super(id, ime, prezime, email, drzava, grad, adresa, brojTelefona, datumRodjenja, datumZaposlenja);
    }
}
