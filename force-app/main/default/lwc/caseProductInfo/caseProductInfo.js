/**
 * description       : Displays customer product information on Case records. 
 * Fetches Product Type and Country from the related Contact to retrieve Product Information from custom object
 * author            : Arpitha A Gowda
 * user story        : Case Study - Task 1.
 */
import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import Product_FIELD from "@salesforce/schema/Case.Contact.Product__c";
import Country_FIELD from "@salesforce/schema/Case.Contact.Home_Country__c";
import getProductDetails from '@salesforce/apex/ProductController.getProductDetails';

export default class caseProductInfo extends LightningElement {
    @api recordId;
    productDetails;
    error;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: [Product_FIELD, Country_FIELD]
    })
    caseRecord;

    get pName() {
        return getFieldValue(this.caseRecord.data, Product_FIELD);
    }

    get cName() {
        return getFieldValue(this.caseRecord.data, Country_FIELD);
    }
    // Fetching the matching product information
    @wire(getProductDetails, { 
        product: '$pName', 
        country: '$cName' 
    })
    wiredProductDetails({ error, data }) {
        if (data) {
            this.productDetails = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.productDetails = undefined;
        }
    }

    get atmFeeDisplay() {
        const fee = this.productDetails?.ATM_Fee_in_Other_Currencies__c;
                if (fee === 0) {
            return 'FREE';
        }
        return fee != null ? fee / 100: null;
    }

    get isFeeFree() {
        return this.atmFeeDisplay === 'FREE';
    }
    
}
