/**
 * Created by eshemetov on 28/09/2021.
 */

public with sharing class CurrencyRatesController {

    @AuraEnabled(Cacheable = true)
    public static String getRates(Date chosenDate) {
        if (chosenDate == null) return null;

        String formattedDate = '' + chosenDate.year() + '-' + chosenDate.month() + '-' + chosenDate.day();
        String stringRequest = 'https://www.nbrb.by/api/exrates/rates?ondate='+ formattedDate + '&periodicity=0';
        Http http = new Http();
        HttpRequest ratesRequest = new HttpRequest();
        ratesRequest.setEndpoint(stringRequest);
        ratesRequest.setMethod('GET');
        ratesRequest.setTimeout(120000);

        HttpResponse ratesResponse = http.send(ratesRequest);
        if (ratesResponse.getStatus() == 'OK') {
            return ratesResponse.getBody();
        }

        return null;
    }
}