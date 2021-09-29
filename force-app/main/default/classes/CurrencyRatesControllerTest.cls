/**
 * Created by eshemetov on 29/09/2021.
 */

@IsTest
private class CurrencyRatesControllerTest {
    @IsTest
    static void testBehavior() {
        Date testDate = Date.today();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.startTest();
        String responseJSON = CurrencyRatesController.getRates(testDate);
        System.debug(responseJSON);
        List<Object> rates = (List<Object>) JSON.deserializeUntyped(responseJSON);
        Test.stopTest();
        System.assertEquals(3, rates.size());
    }

    private class RestMock implements HttpCalloutMock {

        public HttpResponse respond(HttpRequest req) {
            String fullJson = '[{"Cur_ID":440,"Date":"2021-09-07T00:00:00","Cur_Abbreviation":"AUD","Cur_Scale":1,"Cur_Name":"Австралийский доллар","Cur_OfficialRate":1.8688},' +
                    '{"Cur_ID":510,"Date":"2021-09-07T00:00:00","Cur_Abbreviation":"AMD","Cur_Scale":1000,"Cur_Name":"Армянских драмов","Cur_OfficialRate":5.0990},' +
                    '{"Cur_ID":441,"Date":"2021-09-07T00:00:00","Cur_Abbreviation":"BGN","Cur_Scale":1,"Cur_Name":"Болгарский лев","Cur_OfficialRate":1.5286}]';

            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/json');
            res.setBody(fullJson);
            res.setStatus('OK');
            return res;
        }
    }

}