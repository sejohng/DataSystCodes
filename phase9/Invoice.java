/*
Shijun Jiang
CSCI 4125 Fall 2023
Phase9
*/

import java.sql.*;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Scanner; 

public class Invoice {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);  
        
        System.out.println("Enter Customer ID:");
        String customerId = scanner.nextLine(); 
        System.out.println("Enter Order Date (dd-MON-yy):");
        String orderDateString = scanner.nextLine(); 
        scanner.close(); 
        
        Date orderDate = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
            java.util.Date parsedDate = dateFormat.parse(orderDateString.toUpperCase());
            orderDate = new java.sql.Date(parsedDate.getTime());
        } catch (ParseException e) {
            System.out.println("The date format you entered is incorrect, please try again");
            e.printStackTrace();
            return; 
        }
        
        Connection c = null;
        try {
            c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:Oracle21c", "sjiang5", "NewOrleans123");
            c.setAutoCommit(false);
            
            Statement s = c.createStatement();
            
            String customerSql = "SELECT C_Name FROM CUSTOMER WHERE C_ID = '" + customerId + "'";
            String ordersSql = "SELECT COUNT(*) FROM ORDERS WHERE O_CustID = '" + customerId + "' AND O_OrderDate = TO_DATE('" + orderDateString.toUpperCase() + "', 'DD-MON-YY')";
            String orderDetailsSql = "SELECT L.L_ProductID, P.P_Name, L.L_Quantity, P.P_Price FROM LINEITEM L JOIN PRODUCT P ON L.L_ProductID = P.P_ID WHERE L.L_OrderNumber IN (SELECT O_OrderNumber FROM ORDERS WHERE O_CustID = '" + customerId + "' AND O_OrderDate = TO_DATE('" + orderDateString.toUpperCase() + "', 'DD-MON-YY'))";
            
            
            // Execute the query for customer name
            ResultSet customerRs = s.executeQuery(customerSql);
            if (customerRs.next()) {
                String customerName = customerRs.getString("C_Name");
                System.out.println();
                
                ResultSet ordersRs = s.executeQuery(ordersSql);
                if (ordersRs.next() && ordersRs.getInt(1) > 0) {
                    
                    //Provide an invoice header that includes: order date, customer ID, and customer name
                	SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MMM-yy");
                	String formattedDate = outputFormat.format(orderDate).toUpperCase();
                	System.out.println(formattedDate + " invoice for " + customerId + ": " + customerName);
                    System.out.println(String.format("%-30s %10s %-10s %10s", "Product", "Quantity", "Price/Unit", "Total"));
                    System.out.println("---------------------------------------------------------------");
                    
                    ResultSet orderDetailsRs = s.executeQuery(orderDetailsSql);
                    BigDecimal totalProductCost = BigDecimal.ZERO;
                    BigDecimal shippingCost = BigDecimal.ZERO;
                    
                    while (orderDetailsRs.next()) {
                        String productName = orderDetailsRs.getString("P_Name");
                        int quantity = orderDetailsRs.getInt("L_Quantity");
                        BigDecimal price = orderDetailsRs.getBigDecimal("P_Price");
                        BigDecimal linePrice = price.multiply(BigDecimal.valueOf(quantity));
                        
                        totalProductCost = totalProductCost.add(linePrice);
                        //List all products in the order, the quantity, the price/unit, and the total line price (i.e., quantity * price/unit).
                        System.out.format("%-30s %10d %10s %10s%n", productName, quantity, String.format("$%.2f", price), String.format("$%.2f", linePrice));
                        
                    }
                    orderDetailsRs.close(); 
                    
                    //Display the total cost for all products, the shipping cost ($0 if total product cost >= $35, else $10), and the total cost (i.e., total product cost plus shipping cost).
                    shippingCost = (totalProductCost.compareTo(new BigDecimal("35")) >= 0) ? BigDecimal.ZERO : new BigDecimal("10");
                    
                    System.out.println();
                    System.out.format("%-30s %10s%n", "Total Product Cost:", String.format("$%.2f", totalProductCost));
                    System.out.format("%-30s %10s%n", "Shipping Cost:", String.format("$%.2f", shippingCost));
                    System.out.format("%-30s %10s%n", "Total Due:", String.format("$%.2f", totalProductCost.add(shippingCost)));
                } else {
                    System.out.println("No report to generate!");
                    //If the customer has not placed an order on the given date, print a message “No invoice to generate” and return.
                }
                ordersRs.close(); 
            } else {
                System.out.println("The Customer_ID format is incorrect or does not exist, please try again.");
            }
            customerRs.close(); 
            s.close(); 
            c.commit();
            
        } catch (SQLException e) {
            System.err.println("Database operation failed");
            e.printStackTrace();
            if (c != null) {
                try {
                    c.rollback();
                } catch (SQLException ex) {
                    System.err.println("Transaction rollback failed");
                    ex.printStackTrace();
                }
            }
        } finally {
            if (c != null) {
                try {
                    c.close();
                } catch (SQLException e) {
                    System.err.println("Closing connection failed");
                    e.printStackTrace();
                }
            }
        }
    }
}
