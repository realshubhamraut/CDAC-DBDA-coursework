
import java.io.*;

class CharStreamDemo {

    public static void main(String[] args) throws IOException {
        File f = new File("C:/Users/Shweta/Documents/JavaAssign1code/Input.txt");
        File fo = new File("ot.txt");
        if (!f.exists()) {
            System.out.println("File does not exist..");
            return;
        }
        FileReader fr = new FileReader(f);
        FileWriter fw = new FileWriter(fo);
        BufferedReader bi = new BufferedReader(fr);
        BufferedWriter bo = new BufferedWriter(fw);
        /*int ch;
        while ((ch = fr.read()) != -1) {

            System.out.println(ch);

        }*/
        //        fr.close();

        fw.flush();
        //    fw.close();
        bi.close();
        bo.close();
    }
}
