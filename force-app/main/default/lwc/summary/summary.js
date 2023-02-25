import { LightningElement, wire } from 'lwc';
import { subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import MESSAGE_CHANNEL from '@salesforce/messageChannel/SummaryMessageChannel__c';
import getAccountContactDetails from '@salesforce/apex/SummaryController.getAccountContactDetails';
export default class Summary extends LightningElement {
    selectedItemId;
    account;
    contact;
    relatedAccount;
    subscription = null;

    @wire(MessageContext) messageContext;

    connectedCallback() {
        this.subscription = subscribe(this.messageContext, MESSAGE_CHANNEL, message => {
            this.selectedItemId = message.selectedItemId;
        });
    }

    disconnectedCallback() {
        unsubscribe(this.subscription);
    }

    @wire(getAccountContactDetails, { selectedItemId: '$selectedItemId' })
    wiredDetails({ error, data }) {
        if (data) {
            this.account = data.account;

            if (data.contact) {
                this.contact = data.contact;
                this.relatedAccount = data.relatedAccount;
            } else {
                this.contact = null;
                this.relatedAccount = null;
            }
        } else if (error) {
            console.error(error);
        }
    }
}
