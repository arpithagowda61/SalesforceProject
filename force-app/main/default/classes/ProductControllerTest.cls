/**
     * @Description : Test class for productController
     * @User Story  : Case Study - Senior Salesforce Engineer Task 1.
     * @author      : Arpitha A Gowda
     */

@isTest
private class productControllerTest {

    @isTest
    static void testGetProductDetailsSuccess() {
        // Use the Factory instead of manual instantiation
        TestDataFactory.createProductPlan('Black', 'DE');
        Test.startTest();
        Product_Plan__c result = ProductController.getProductDetails('Black', 'DE');
        Test.stopTest();
        System.assertNotEquals(null, result, 'Plan should be found via Factory data.');  
    }
    
    @isTest
static void testGetProductDetails_BlankInputs() {
    Test.startTest();
    Product_Plan__c result1 = ProductController.getProductDetails('', 'DE');
    Product_Plan__c result2 = ProductController.getProductDetails('Black', null);
    Product_Plan__c result3 = ProductController.getProductDetails(null, null);
    Test.stopTest();
    System.assertEquals(null, result1, 'Should return null if product is blank');
    System.assertEquals(null, result2, 'Should return null if country is null');
    System.assertEquals(null, result3, 'Should return null if both inputs are missing');
}
}
