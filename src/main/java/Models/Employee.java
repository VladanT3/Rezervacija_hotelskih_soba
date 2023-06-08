package Models;

public class Employee extends User {
    protected String dateOfHiring;

    public Employee() {
    }

    public Employee(String id, String firstName, String lastName, String email, String country, String city, String address, String phoneNumber, String birthday, String dateOfHiring) {
        super(id, firstName, lastName, email, country, city, address, phoneNumber, birthday);
        this.dateOfHiring = dateOfHiring;
    }

    public String getDateOfHiring() {
        return dateOfHiring;
    }
}
