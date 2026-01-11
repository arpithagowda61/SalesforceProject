/**
 * @Description : Centralized Factory for creating test data.
 * Scales well as new requirements (contract length, etc.) are added.
 */
@isTest
public class TestDataFactory {
    
    // Method to create the Product Plan record
    public static Product_Plan__c createProductPlan(String prodType, String country) {
        Product_Plan__c plan = new Product_Plan__c(
            Product__c = prodType,
            Home_Country__c = country,
            Cost_per_Calendar_Month__c = 0,
            ATM_Fee_in_Other_Currencies__c = 1.7,
            Card_Replacement_Cost__c = 6.00
        );
        insert plan;
        return plan;
    }

    // Method to create a Contact with a UUID
    public static Contact createContact(String lastName, String prodType, String country, String uuid) {
        Contact con = new Contact(
            LastName = lastName,
            Product__c = prodType,
            Home_Country__c = country,
            UUID__c = uuid
        );
        insert con;
        return con;
    }
}