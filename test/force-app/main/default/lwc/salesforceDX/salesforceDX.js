/* eslint-disable no-console */
import { LightningElement,track, api } from 'lwc';

export default class SalesforceDX extends LightningElement {
    @track config = false;
    @track getObject = false;
    @track uploadCSV = false;
    @api selectedVal;
    @track selectedId;
    connectedCallback() {
        // initialize component
        this.getObject = true;
    }
    handleChange(event) {
        var selectedId =  event.target.id;
        var selectedtab;
        if(selectedId.includes('about')){
            this.selectedVal = 'about';
            selectedtab = 'about';
        }
        if(selectedId.includes('blog')){
            this.selectedVal = 'blog';
            selectedtab = 'blog';
        }
        if(selectedId.includes('projects')){
            this.selectedVal = 'projects';
            selectedtab = 'projects';
        }
        if(selectedId.includes('contact')){
            this.selectedVal = 'contact';
            selectedtab = 'contact';
        }
        console.log('=====selectedId====',this.selectedVal);
        const filterChangeEvent = new CustomEvent('filterchange', { detail: {selectedtab}, });
        // Fire the custom event
        this.dispatchEvent(filterChangeEvent);
       
    }
   
}