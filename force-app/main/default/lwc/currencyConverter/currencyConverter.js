/**
 * Created by eshemetov on 29/09/2021.
 */

import {LightningElement, track} from 'lwc';

export default class CurrencyConverter extends LightningElement {
    @track currencyList = [];

    amount;
    currency;
    currentCurrency;
    convertedAmount;

    uri = 'https://www.nbrb.by/api/exrates/rates?periodicity=0';

    getCurrencyData() {
        fetch (this.uri)
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
            })
            .then(data => {
                let currencyArray = [];
                data.map(currency => {
                    currencyArray.push({
                        label : currency.Cur_Abbreviation,
                        value : currency.Cur_Abbreviation,
                        rate : currency.Cur_OfficialRate,
                        scale : currency.Cur_Scale
                    });
                })
                currencyArray.push({label : 'BYN', value : 'BYN', rate : 1, scale : 1});
                this.currencyList = currencyArray;
            })
            .catch(error => console.log(error));
    }

    connectedCallback() {
        this.getCurrencyData();
    }

    requestConverter() {
        let currencyRecord = this.currencyList.find(currency => currency.value === this.currency);
        let currentCurrencyRecord = this.currencyList.find(currency => currency.value === this.currentCurrency);
        let inBYN = this.amount * currentCurrencyRecord.scale * currentCurrencyRecord.rate;
        this.convertedAmount = inBYN * currencyRecord.scale / currencyRecord.rate;
    }

    setCurrency(event){
        this.currency = event.target.value;
    }

    setCurrentCurrency(event){
        this.currentCurrency = event.target.value;
    }

    setValue(event) {
        this.amount = event.target.value;
    }
}