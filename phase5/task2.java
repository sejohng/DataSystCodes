/*
Shijun Jiang
CSC 4125/5125 Fall 2023
*/

import java.io.*;
import java.math.BigDecimal;


public class task2 {

    public static void main(String[] args) {
        tofindhighestprice("product.csv");
    }

    public static void tofindhighestprice(String filename) {
        String line;
        String cvsSplitBy = ",";
        String highestpriceName = null; //Initially, we don't know which product has the highest price, so we set it to null.
        BigDecimal highestPrice = null; 
        
        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            br.readLine();  // Skip header
            while ((line = br.readLine()) != null) {
                String[] product = line.split(cvsSplitBy);
                    String productName = product[1].trim();
                    BigDecimal productPrice = new BigDecimal(product[2].trim());
                
                    if (highestPrice == null || productPrice.compareTo(highestPrice) > 0) {
                        highestPrice = productPrice;
                        highestpriceName = productName;       //Check one by one and update the largest value.
                    }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(highestpriceName + " " + highestPrice);
    }
}
