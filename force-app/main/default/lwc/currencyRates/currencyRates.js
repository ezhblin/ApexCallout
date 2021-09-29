/**
 * Created by eshemetov on 28/09/2021.
 */
import getRates from "@salesforce/apex/CurrencyRatesController.getRates";
import {LightningElement, track} from 'lwc';

export default class CurrencyRates extends LightningElement {
    @track dataRates;
    chosenDate;
    spinner = false;

    requestRates() {
        this.spinner = true;
        getRates({chosenDate : this.chosenDate})
            .then(result => {
                this.dataRates = JSON.parse(result);
                this.spinner = false;
            })
            .catch(error => {
                console.log('Something wrong!');
                this.spinner = false;
            });
    }

    setValue(event) {
        this.chosenDate = event.target.value;
    }

}