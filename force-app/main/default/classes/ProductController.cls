public with sharing class ProductController {
    /**
     * @Description : Fetches product pricing details based on product type and country.
     * @User Story  : Case Study - Senior Salesforce Engineer Task 1.
     * @author      : Arpitha A Gowda
     * @return      : A single Product_Plan__c record or null if no match is found.
     */
   @AuraEnabled(cacheable=true)
    public static Product_Plan__c getProductDetails(String product, String country) {
        if (String.isBlank(product) || String.isBlank(country)) {
            return null;
        }
        try {
            List<Product_Plan__c> results = [SELECT Cost_per_Calendar_Month__c, ATM_Fee_in_Other_Currencies__c,  Card_Replacement_Cost__c
                FROM Product_Plan__c  WHERE Product__c = :product AND Home_Country__c = :country WITH SECURITY_ENFORCED LIMIT 1
            ];
            return results.isEmpty() ? null : results[0];

        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving product information: ' + e.getMessage());
        }
    }
}