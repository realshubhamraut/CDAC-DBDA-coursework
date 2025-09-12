// Create a Patient class with private attributes id, name, and disease. Provide methods
// to set and get details and restrict modification of id once assigned.


class Patient{
    private Integer id;
    private String name;
    private String disease;

    public int getId(){
        return id;
    }

    public String getName(){
        return name;
    }

    public String getDisease(){
        return disease;
    }

    public void setId(int id){
        if(this.id == null){
            this.id = id;
        }
        else{
            System.out.println("Id cannot be changed once set");
        }
    }

    public void setName(String name){
        this.name = name;


    }

    public void setDisease(String disease){
        this.disease = disease;
    }

}



public class Ques10{
    public static void main(String[] args){
        Patient pt = new Patient();
        pt.setId(23);
        pt.setName("Shubham");
        pt.setDisease("Asthama");

        System.out.println("Id"+ pt.getId());
        System.out.println("Name"+ pt.getName());
        System.out.println("Disease :" +pt.getDisease());


        pt.setId(23);
        System.out.println("Id after trying to change" + pt.getId());

    }

}