package Models;

public class Administrator extends Employee {
    public Administrator() {
    }

    public Administrator(String id, String firstName, String lastName, String email, String country, String city, String address, String phoneNumber, String birthday, String dateOfHiring) {
        super(id, firstName, lastName, email, country, city, address, phoneNumber, birthday, dateOfHiring);
    }
}
