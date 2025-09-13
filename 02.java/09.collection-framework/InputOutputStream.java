
import java.io.*;
//byte stream

class InputOutputStream {

    public static void main(String[] args) throws IOException {
        File f = new File("C:/Users/Shweta/Documents/JavaAssign1code/Input.txt");
        File of = new File("output.txt");
        if (!f.exists()) {
            System.out.println("File does not exist..");
            return;
        }
        FileInputStream fis = new FileInputStream(f);
        FileOutputStream fos = new FileOutputStream(of);
        BufferedInputStream bis = new BufferedInputStream(fis);
        BufferedOutputStream bos = new BufferedOutputStream(fos);
        int ch;
        while ((ch = fis.read()) != -1) {

            System.out.println(ch);

        }
//        fis.close();

        bis.close();
        bos.close();

    }
}
