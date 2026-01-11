@RestResource(urlMapping='/v1/ContactProductDetails/*')
  /**
 * @Description : REST API to expose Contact and Product Rate information to N26 external systems.
 * @User Story  : Case Study - Senior Salesforce Engineer Task 2.
 * @Author      : Arpitha A Gowda
 */
global with sharing class ContactAPI {

    @HttpGet
    global static void doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //Extract UUID from the URL path
        String uuid = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);     
        try {
            //Fetching Contact by UUID
            Contact con = [SELECT Product__c, Home_Country__c FROM Contact WHERE UUID__c = :uuid LIMIT 1];          
            //Fetching matching product Information from Product_plan__c
            Product_Plan__c Fee = [SELECT Cost_per_Calendar_Month__c, ATM_Fee_in_Other_Currencies__c,  Card_Replacement_Cost__c
                                   FROM Product_plan__c 
                                   WHERE Product__c = :con.Product__c 
                                   AND Home_Country__c = :con.Home_Country__c 
                                   LIMIT 1];  
            //JSON response
            res.responseBody = Blob.valueOf(JSON.serialize(Fee));
            res.statusCode = 200;
            
        } catch (Exception e) {
            res.statusCode = 404;
            res.responseBody = Blob.valueOf('{"error": "Record not found"}');
        }
    }
}
