/*
Shijun Jiang
CSC 4125/5125 Fall 2023
Phase6 task2
10-11-2023
*/

import java.io.*;
import java.util.*;

public class task2 {

    public static void main(String[] args) {
        System.out.println("Output for Query #1:");
        findCustWithAddr("address.txt", "customer.txt");
        System.out.println("\n");
        System.out.println("Output for Query #2:");
        totalSold("lineitem.txt");
    }

    public static void findCustWithAddr(String address, String customer) { //Stores a collection of customer IDs with addresses
        Set<String> custIdsWithAddr = new HashSet<>();
        Map<String, String> custIdToName = new HashMap<>();

        try (BufferedReader br = new BufferedReader(new FileReader(address))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] addressData = line.split(",");
                custIdsWithAddr.add(addressData[0].trim());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        try (BufferedReader br = new BufferedReader(new FileReader(customer))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] custData = line.split(",");
                String custId = custData[0].trim();
                String custName = custData[1].trim();
                custIdToName.put(custId, custName);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
         //Print the name of the customer with address
        for (String custId : custIdsWithAddr) {
            System.out.println(custIdToName.get(custId));
        }
    }

    public static void totalSold(String lineitem) {
        Map<String, Integer> productIdToTotalQuantity = new HashMap<>();
        
                try (BufferedReader br = new BufferedReader(new FileReader(lineitem))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        String[] lineitemData = line.split(",");
                        String productId = lineitemData[1].trim();
                        int quantity = Integer.parseInt(lineitemData[2].trim()); //Update or add product sales quantity
                        
                        productIdToTotalQuantity.put(productId, productIdToTotalQuantity.getOrDefault(productId, 0) + quantity);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
        
                // Print results
                for (Map.Entry<String, Integer> entry : productIdToTotalQuantity.entrySet()) {
                    System.out.println(entry.getKey() + ": " + entry.getValue());
                }
            
    }
}
