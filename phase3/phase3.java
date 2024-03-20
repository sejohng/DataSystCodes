// Author：Shijun Jiang  09-08-2023
import java.io.*;
import java.util.*;

public class phase3 {
    
    /* If the length of args is not 1, the program will return immediately, that is, terminate execution  */
    
    public static void main(String[] args) {
        if (args.length != 1) {
            return;
        }

        String tableName = args[0];
        String outFile = String.format("%s.sql", tableName); //string placeholders
        String inFile = String.format("%s.txt", tableName); //string placeholders
        try {
            FileWriter outfile = new FileWriter(outFile);
            File infile = new File(inFile);
            Scanner input = new Scanner(infile);

            while (input.hasNextLine()) {
                String line = input.nextLine();
                if (line.length() > 0) {
                    String processedLine = processLine(line);
                    String insertStatement = String.format("INSERT INTO %s VALUES(%s);\n", tableName, processedLine);
                    outfile.write(insertStatement);
                }
            }
            outfile.write("COMMIT;\n");
            outfile.close();
            input.close();

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public static String processLine(String line) {
        String[] values = line.split(",");
        StringBuilder formattedValues = new StringBuilder();

        for (String value : values) {
            value = value.trim();
            if ("NULL".equalsIgnoreCase(value)) {
                formattedValues.append("NULL,");  //c. NULL values do not use single quotes.
            } else if (isNumeric(value)) {
                formattedValues.append(String.format("%s,", value)); // a.numbers and floats don't use single quotes.
            } else {
                formattedValues.append(String.format("'%s',", value));// b. Strings use single quotes
            }
        }
    
        if (formattedValues.length() > 0) {
            formattedValues.setLength(formattedValues.length() - 1); // Remove the last comma of the statement
        }
        return formattedValues.toString();
    }

    public static boolean isNumeric(String value) {
        try {
            Double.parseDouble(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
