public with sharing class CSV_Configuration {
    @AuraEnabled(cacheable=true)
    public static CredentialDetailsWrapper searchCredentailRecord(){
        CredentialDetailsWrapper wrapperDetails = new CredentialDetailsWrapper();
        try{
            List<uploadCSV__Credentials__c> credentialDetails = uploadCSV__Credentials__c.getall().values();
            system.debug('==credentialDetails=='+credentialDetails);
            if(credentialDetails.size()>0){
                wrapperDetails.credentialDetails = credentialDetails[0];    
                wrapperDetails.isError = false;   
            }
            system.debug('==wrapperDetails=='+wrapperDetails);
        }
        catch(Exception ex) {
            wrapperDetails.isError = true;
            wrapperDetails.message = ex.getMessage();
            System.debug('Error'+ex.getMessage());
        }
        return wrapperDetails;
    }
    @AuraEnabled
    public static void saveAccountRecord(String objRecordDetails){
        try{
            if(objRecordDetails != null){
                uploadCSV__Credentials__c setting = new uploadCSV__Credentials__c();
                setting = (uploadCSV__Credentials__c)JSON.deserialize(objRecordDetails, uploadCSV__Credentials__c.class);
                setting.Name = UserInfo.getFirstName()+' '+ UserInfo.getLastName();
                insert setting;
             }           
        }
        catch(Exception ex) {
            System.debug('Error'+ex.getMessage());
        }
    }

    @AuraEnabled
    public static ValidateWrapper validateUser(){
        ValidateWrapper wrap = new ValidateWrapper();
        try{            
            List<uploadCSV__Credentials__c> CredentialList = uploadCSV__Credentials__c.getall().values();
            system.debug('==CredentialList=='+CredentialList);
            if(CredentialList !=null && CredentialList.size()>0){
                Httprequest req = new HttpRequest();
                req.setMethod('POST');
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                String password = CredentialList[0].uploadCSV__Password__c+CredentialList[0].uploadCSV__Security_Token__c;
                req.setBody('grant_type=password' +
                '&client_id=' + CredentialList[0].uploadCSV__Client_Id__c +
                '&client_secret=' + CredentialList[0].uploadCSV__Client_Secret__c +
                '&username=' + CredentialList[0].uploadCSV__Username__c +
                '&password=' + password );
                String endpoint = CredentialList[0].uploadCSV__URL__c+'/services/oauth2/token';
                req.setEndpoint(endpoint);
                Http http = new Http();
                HttpResponse res;
                try {
                    res = http.send(req);
                    system.debug('body:' + res.getBody());
                    system.debug('getStatus:' + res.getStatus());
                    system.debug('getStatusCode:' + res.getStatusCode());
                    JSONParser parser = JSON.createParser(res.getBody());
                    if(res.getStatusCode() == 200){
                        wrap.variant = 'success';
                        wrap.message = 'Successfully Validate!!';
                        CredentialList[0].uploadCSV__Validate__c = true;
                        update CredentialList;
                    }
                } catch (system.CalloutException e) {
                    system.debug('error' + e.getMessage());
                    wrap.variant = 'error';
                    wrap.message = e.getMessage();
                }
            }else{
                wrap.variant = 'error';
                wrap.message = 'Please Configure Salesforce Org!!';
            }      
        }
        catch(Exception ex) {
            wrap.variant = 'error';
            wrap.message = ex.getMessage();
            System.debug('Error'+ex.getMessage());
        }
        return wrap;
    }
    // wrapper class with @AuraEnabled and {get;set;} properties 
    public class CredentialDetailsWrapper{
        @AuraEnabled 
        public Object credentialDetails {get;set;}
        @AuraEnabled 
        public Boolean isError{get;set;}
        @AuraEnabled 
        public String message{get;set;}
    }
    // wrapper class with @AuraEnabled and {get;set;} properties 
    public class ValidateWrapper{
        @AuraEnabled 
        public String variant{get;set;}
        @AuraEnabled 
        public String message{get;set;}
    }
}