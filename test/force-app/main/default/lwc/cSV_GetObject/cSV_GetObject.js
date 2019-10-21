/* eslint-disable no-console */
import { LightningElement,track,wire } from 'lwc';
// Importing Apex Class method
import searchRecord from '@salesforce/apex/CSV_GetObject.getObject';
import getFields from '@salesforce/apex/CSV_GetObject.getFields';
import getData from '@salesforce/apex/CSV_GetObject.getData';
export default class CSV_GetObject extends LightningElement {
@track error;
@track isSpinner = true;
@track isOpen = false;
@track objectName;
@track value = '--select--';
@track optionsList =[];
@track options =[];
@track disabled = true;
@track _selected = [];
@track data;
get selected() {
    return this._selected.length ? this._selected : 'none';
}

@wire(searchRecord)
    wiredRecord({error, data}) {
        if (data) {
           const items = [];
           for(let i=0;i<data.length;i++){
                items.push({
                    label: data[i].Name,
                    value: data[i].APIName,
                });
           }
           this.optionsList = items;
           this.isSpinner = false;
        } else if (error) {
            this.error = error;
            console.log('error: ', JSON.stringify(error));
        }
    }
    handleChange(event){
        this.isSpinner = true;
        this.objectName = event.detail.value;
        getFields({ objectName: event.detail.value})
            .then(result => {
                if(result){
                    const items = [];
                    for(let i=0;i<result.length;i++){
                         items.push({
                             label: result[i].label,
                             value: result[i].name,
                         });
                    }
                    this.options = items;
                    this.isSpinner = false; 
                    this.disabled = false;
                }
            })
            .catch(error => {
                this.error = error.message;
            });
    }
    handleDualChange(event){
        this._selected = event.detail.value;
    }
    downloadCSV(){
        console.log('===Object Name===',this.objectName);
        console.log('===Object Name===',this._selected);
        getData({ objectName: this.objectName, fields : this._selected})
        .then(result => {
            console.log('===result==='+JSON.stringify(result));                   
            this.data = result;
            this.error = undefined;
        })
        .then(result => {
            this.data = result;
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            this.data = undefined;
        });
    }
}