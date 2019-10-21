/* eslint-disable no-console */
import { LightningElement, track, wire } from 'lwc';

// Importing Apex Class method
import searchRecord from '@salesforce/apex/CSV_Configuration.searchCredentailRecord';
import saveRecords from '@salesforce/apex/CSV_Configuration.saveAccountRecord';
import validateRecords from '@salesforce/apex/CSV_Configuration.validateUser';
// importing Credential__c object
//import Credential from '@salesforce/schema/Credential__c';
// importing to show toast notifictions
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class cSV_Configuration extends LightningElement {
    @track isOpen = false;
    @track isRegistered = false;
    @track isValidated = false;
    @track error;
    @track credentialRecords;
    @track data = {};
    @wire(searchRecord)
    wiredRecord({error, data}) {
        if (data) {
           console.log('data: '+JSON.stringify(data));
           if(data.isError){
               this.error = data.message;
           }else{
               if(data.credentialDetails.uploadCSV__Validate__c){
                    this.data = data.credentialDetails;
                    console.log('===data.credentialDetails==='+JSON.stringify(data.credentialDetails));
                    this.isRegistered = true;
               }             
           }
        } else if (error) {
            console.log('error: ', JSON.stringify(error));
        }
    }
    @track credentialObject = {
        uploadCSV__Client_Id__c: '',
        uploadCSV__Client_Secret__c: '',
        uploadCSV__Password__c: '',
        uploadCSV__Username__c: '',
        uploadCSV__Security_Token__c: '',
        uploadCSV__URL__c : ''
    };
    handleConfiguration() {
        searchRecord()
            .then(result => {
                // Clear the user enter values
                this.isOpen = true;
                console.log('===result==='+result);
                if(result === true){
                    this.isRegistered = true;
                }else{
                    this.isRegistered = false;
                }
            })
            .catch(error => {
                this.error = error.message;
            });
        
    }
    closeModal() {
        this.isOpen = false;
    }
    saveRecords() {
        saveRecords({ objRecordDetails: JSON.stringify(this.credentialObject) })
            .then(result => {
                // Clear the user enter values
                this.credentialObject = {};
                this.isOpen = false;

                window.console.log('result ===> ' + result);
                // Show success messsage
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!!',
                    message: 'Record Created Successfully!!',
                    variant: 'success'
                }));
            })
            .catch(error => {
                this.error = error.message;
            });
    }

    handleClientIdChange(event) {
        this.credentialObject.uploadCSV__Client_Id__c = event.target.value;
    }

    handleClientSecretChange(event) {
        this.credentialObject.uploadCSV__Client_Secret__c = event.target.value;
    }

    handleUsernameChange(event) {
        this.credentialObject.uploadCSV__Username__c = event.target.value;
    }

    handlePasswordChange(event) {
        this.credentialObject.uploadCSV__Password__c = event.target.value;
    }

    handletokenChange(event) {
        this.credentialObject.uploadCSV__Security_Token__c = event.target.value;
    }

    handleUrlChange(event) {
        this.credentialObject.uploadCSV__URL__c = event.target.value;
    }
    
    handleValidation(){
        validateRecords()
        .then(result => {
            window.console.log('result ===> ' + result);
            // Show success messsage
            this.dispatchEvent(new ShowToastEvent({
                title: result.variant,
                message: result.message,
                variant: result.variant
            }));
        })
        .catch(error => {
            this.error = error.message;
        });
    }
}