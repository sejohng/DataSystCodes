// Author：Shijun Jiang  08-20-2023

import java.io.*;
import java.util.*;

public class phase1 {

    public static void main(String[] args) {
        try {
            // Create a file to write results to
            FileWriter outfile = new FileWriter("phase1_fall2023_result.csv");
            
            // Read an input file
            File infile = new File("phase1_fall2023.txt");
            Scanner input = new Scanner(infile);

            // Read the file line by line.
            while (input.hasNextLine()) {
                String line = input.nextLine(); // Store that line in a String variable

                if (line.length() == 0) { // If the line doesn't have any info, skip it.
                    outfile.write("\n");
                } else {
                    outfile.write(processLine(line) + "\n"); // Write our data processing to the outfile
                }
            }
            
            outfile.close(); 
            input.close();   
            
        } catch (FileNotFoundException e) {
            // Need to catch FNFE for FileWriter and Scanner
            System.out.println(e.getMessage());
        } catch (IOException e) {
            // Need to catch IOE for FileWriter
            System.out.println(e.getMessage());
        }
    }

    public static String processLine(String line) {
        String[] values = line.split(","); 
        ArrayList<String> types = new ArrayList<>();

        for (String value : values) {
            value = value.trim();
            types.add(determineType(value));
        }

        return String.join(", ", types);
    }

    public static String determineType(String value) {
        try {
            Integer.parseInt(value);
            return "Integer";
        } catch (NumberFormatException e1) {
            try {
                Float.parseFloat(value);
                return "Float";
            } catch (NumberFormatException e2) {
                return "String";
            }
        }
    }
}
