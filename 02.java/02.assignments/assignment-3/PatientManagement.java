import java.util.ArrayList;
import java.util.Scanner;

class Patient {
    private String patientId;
    private String name;
    private String diagnosis;
    private int admitDay;

    Patient(String patientId, String name, String diagnosis, int admitDay) {
        this.patientId = patientId;
        this.name = name;
        this.diagnosis = diagnosis;
        this.admitDay = admitDay;
    }

    // Getters
    String getPatientId() {
        return patientId;
    }

    String getName() {
        return name;
    }

    String getDiagnosis() {
        return diagnosis;
    }

    int getAdmitDay() {
        return admitDay;
    }

    void display() {
        System.out.println("Patient Id: " + patientId +
                           ", Name: " + name +
                           ", Diagnosis: " + diagnosis +
                           ", Days Admitted: " + admitDay);
    }
}

public class PatientManagement {
    private ArrayList<Patient> patients;

    public PatientManagement() {
        patients = new ArrayList<>();
    }

    void addPatient(Patient p) {
        patients.add(p);
        System.out.println("Patient added successfully.");
    }

    void removePatient(String pid) {
        boolean removed = patients.removeIf(patient -> patient.getPatientId().equals(pid));
        if (removed) {
            System.out.println("Patient removed successfully.");
        } else {
            System.out.println("Patient not found.");
        }
    }

    void searchDiagnosis(String diagnosis) {
        boolean found = false;
        System.out.println("Patients with Diagnosis '" + diagnosis + "':");
        for (Patient patient : patients) {
            if (patient.getDiagnosis().equalsIgnoreCase(diagnosis)) {
                patient.display();
                found = true;
            }
        }
        if (!found) {
            System.out.println("No patients found for this diagnosis.");
        }
    }

    void findPatientsByDays(int days) {
        boolean found = false;
        System.out.println("Patients admitted more than " + days + " days:");
        for (Patient patient : patients) {
            if (patient.getAdmitDay() > days) {
                patient.display();
                found = true;
            }
        }
        if (!found) {
            System.out.println("No patients found admitted more than " + days + " days.");
        }
    }

    void displayAll() {
        if (patients.isEmpty()) {
            System.out.println("No patients admitted.");
        } else {
            System.out.println("All Patients:");
            for (Patient patient : patients) {
                patient.display();
            }
        }
    }

    public static void main(String[] args) {
        PatientManagement pm = new PatientManagement();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\n1. Add Patient Details");
            System.out.println("2. Remove Patient Details");
            System.out.println("3. Find Patients with Specific Diagnosis");
            System.out.println("4. Find Patients Admitted More Than Given Days");
            System.out.println("5. Display All Patients");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");

            int choice = scanner.nextInt();
            scanner.nextLine(); // consume the newline

            switch (choice) {
                case 1:
                    System.out.print("Enter Patient Id: ");
                    String id = scanner.nextLine();
                    System.out.print("Enter Patient Name: ");
                    String name = scanner.nextLine();
                    System.out.print("Enter Patient Diagnosis: ");
                    String dia = scanner.nextLine();
                    System.out.print("Enter Number of Days Admitted: ");
                    int day = scanner.nextInt();
                    scanner.nextLine(); // consume newline
                    Patient patient = new Patient(id, name, dia, day);
                    pm.addPatient(patient);
                    break;

                case 2:
                    System.out.print("Enter Patient Id to remove: ");
                    String rid = scanner.nextLine();
                    pm.removePatient(rid);
                    break;

                case 3:
                    System.out.print("Enter Diagnosis to search: ");
                    String pdia = scanner.nextLine();
                    pm.searchDiagnosis(pdia);
                    break;

                case 4:
                    System.out.print("Enter minimum number of days admitted: ");
                    int minDays = scanner.nextInt();
                    scanner.nextLine();
                    pm.findPatientsByDays(minDays);
                    break;

                case 5:
                    pm.displayAll();
                    break;

                case 6:
                    System.out.println("Exiting Patient Management System. Goodbye!");
                    scanner.close();
                    System.exit(0);

                default:
                    System.out.println("Invalid choice. Please enter a valid option.");
            }
        }
    }
}
