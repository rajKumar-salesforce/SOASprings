import { LightningElement } from 'lwc';
import recentlyCreatedAccounts from '@salesforce/apex/SoaHandler.recentlyCreatedAccounts'
const accountColumns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency', typeAttributes: { currencyCode: 'USD' }},
    { label: 'Rating', fieldName: 'Rating', type: 'percent' }
    
    
];
export default class RecentlyCreatedAccounts extends LightningElement {
    
    columns = accountColumns;
    recentlyCreatedAccounts = [];
    connectedCallback(){
        this.accountsCreatedHandler();
    }
    
    accountsCreatedHandler(){
        recentlyCreatedAccounts()
        .then(result => {
            this.recentlyCreatedAccounts = result;
        })
        .catch(error => {
            console.log('error', error);
        });
    }
    
}