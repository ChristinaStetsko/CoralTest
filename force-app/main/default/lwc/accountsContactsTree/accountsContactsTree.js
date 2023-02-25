import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import MESSAGE_CHANNEL from '@salesforce/messageChannel/SummaryMessageChannel__c';
import getTreeData from '@salesforce/apex/AccountContactsController.getTreeData';

export default class AccountsContactsTree extends LightningElement {
    treeData;
    selectedItemId;
    isLoading = true;
    @wire(MessageContext) messageContext;

    @wire(getTreeData)
    wiredAccounts({ error, data }) {
        if (data) {
            this.treeData = data;
            this.isLoading = false;
        } else if (error) {
            console.error(error);
        }
    }

    handleOnselect(event) {
        this.selectedItemId = event.detail.name;

        const message = {
            selectedItemId: this.selectedItemId
        };
        publish(this.messageContext, MESSAGE_CHANNEL, message);
    }
}
