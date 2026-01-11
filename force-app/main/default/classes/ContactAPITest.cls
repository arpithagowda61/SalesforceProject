/**
 * @Description : Test class for ContactAPI REST Resource.
 * @Author      : Arpitha A Gowda
 */
@isTest
private class ContactAPITest {

    private static final String BASE_URL = '/services/apexrest/v1/ContactProductDetails/';

    @isTest
    static void testGetContactDetailsSuccess() {

        String testUuid = '550e8400';
        TestDataFactory.createProductPlan('Black', 'DE');
        TestDataFactory.createContact('Gowda', 'Black', 'DE', testUuid);
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = BASE_URL + testUuid;
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        ContactAPI.doGet();
        Test.stopTest();

        System.assertEquals(200, res.statusCode, 'Status code should be 200 Success');
        System.assertNotEquals(null, res.responseBody, 'Response body should not be null');
        
    }

    @isTest
    static void testGetContactDetailsNotFound() {
        // 1. Setup Request with a UUID that does not exist in the DB
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = BASE_URL + 'invalid-uuid';
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        ContactAPI.doGet();
        Test.stopTest();

        System.assertEquals(404, res.statusCode, 'Status code should be 404 for missing records');
        String errorJson = res.responseBody.toString();
        System.assert(errorJson.contains('Record not found'), 'The response should contain the correct error message');
    }
}
