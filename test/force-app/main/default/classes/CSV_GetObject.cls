public with sharing class CSV_GetObject {
   /* @AuraEnabled(cacheable=true)
    public static List<ObjectWrapper> getObject(){      
        List<ObjectWrapper> wrapper = new List<ObjectWrapper>();
        List<uploadCSV__Credential__c> CredentialList = new List<uploadCSV__Credential__c>();
        CredentialList = CSV_Configuration.getCredentials();
        if(CredentialList !=null && CredentialList.size()>0){
            String accessToken = CSV_AccessToken.getAccessToken(CredentialList);
            if(String.isNotBlank(accessToken)){
                String authorization = 'Bearer '+ accessToken;
                Httprequest req = new HttpRequest();
                req.setMethod('GET');
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setHeader('Authorization', authorization);
                String endpoint = CredentialList[0].URL__c+'/services/data/v46.0/sobjects/';
                req.setEndpoint(endpoint);
                Http http = new Http();
                HttpResponse res;
                try{
                    res = http.send(req);
                    system.debug('body:' + res.getBody());
                    system.debug('getStatus:' + res.getStatus());
                    system.debug('getStatusCode:' + res.getStatusCode());
                    ObjectDetailsWrapper wraperdata = new ObjectDetailsWrapper();
                    wraperdata = (ObjectDetailsWrapper)JSON.deserialize(res.getBody(), ObjectDetailsWrapper.class);
                    system.debug('===wraperdata==='+wraperdata);
                    List<sobjectsWrapper> objectList = new List<sobjectsWrapper>();
                    objectList = wraperdata.sobjects;
                    system.debug('=====objectList==='+objectList);
                    
                    if(objectList.size()>0){
                        for(sobjectsWrapper obj : objectList){
                            if(obj.createable != false && obj.deletable !=false && obj.queryable !=false && obj.searchable !=false && obj.triggerable !=false && obj.updateable != false){
                                ObjectWrapper wrapObj = new ObjectWrapper();
                                wrapObj.Name = obj.label;
                                wrapObj.APIName = obj.name;
                                wrapper.add(wrapObj);
                            }
                        }
                    }
                }catch(Exception ex){
                    system.debug('====Error===='+ex.getMessage());
                }
            }
        }        
        return wrapper;
    } 
    @AuraEnabled(cacheable=true)
    public static List<CSV_Wrapper.FieldsWrap> getFields(String objectName){      
        List<CSV_Wrapper.FieldsWrap> wrapper = new List<CSV_Wrapper.FieldsWrap>();
        List<uploadCSV__Credential__c> CredentialList = new List<uploadCSV__Credential__c>();
        CredentialList = CSV_Configuration.getCredentials();
        if(CredentialList !=null && CredentialList.size()>0){
            String accessToken = CSV_AccessToken.getAccessToken(CredentialList);
            if(String.isNotBlank(accessToken)){
                String authorization = 'Bearer '+ accessToken;
                Httprequest req = new HttpRequest();
                req.setMethod('GET');
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setHeader('Authorization', authorization);
                String endpoint = CredentialList[0].URL__c+'/services/data/v46.0/sobjects/'+objectName+'/describe';
                req.setEndpoint(endpoint);
                Http http = new Http();
                HttpResponse res;
                try{
                    res = http.send(req);
                    system.debug('body:' + res.getBody());
                    system.debug('getStatus:' + res.getStatus());
                    system.debug('getStatusCode:' + res.getStatusCode());
                    if(res.getStatusCode() == 200){
                        CSV_Wrapper.FieldsWrapper wraperdata = new CSV_Wrapper.FieldsWrapper();
                        wraperdata = (CSV_Wrapper.FieldsWrapper)JSON.deserialize(res.getBody(), CSV_Wrapper.FieldsWrapper.class);
                        System.debug('wraperdata==='+wraperdata);
                        wrapper =   wraperdata.fields;                  
                    } 
                    
                }catch(Exception ex){
                    system.debug('====Error===='+ex.getMessage());
                }
            }
        }        
        return wrapper;
    } 
    @AuraEnabled(cacheable=true)
    public static void getData(String objectName, List<String> fields){      
        system.debug('===objectName==='+objectName);
        system.debug('===fields==='+fields);
    } 
    
     
    // wrapper class with @AuraEnabled and {get;set;} properties 
    public class ObjectDetailsWrapper{
        @AuraEnabled 
        public String encoding {get;set;}
        @AuraEnabled 
        public Integer maxBatchSize{get;set;}
        @AuraEnabled 
        public List<sobjectsWrapper> sobjects{get;set;}
    }
     public class sobjectsWrapper{
        @AuraEnabled 
        public Boolean activateable {get;set;}
        @AuraEnabled 
        public Boolean createable{get;set;}
        @AuraEnabled 
        public Boolean custom{get;set;}
        @AuraEnabled 
        public Boolean customSetting{get;set;}
        @AuraEnabled 
        public Boolean deletable{get;set;}
        @AuraEnabled 
        public Boolean deprecatedAndHidden{get;set;}
        @AuraEnabled 
        public Boolean feedEnabled{get;set;}
        @AuraEnabled 
        public Boolean hasSubtypes{get;set;}
        @AuraEnabled 
        public Boolean isSubtype{get;set;}
        @AuraEnabled 
        public String keyPrefix{get;set;}
        @AuraEnabled 
        public String label{get;set;}
        @AuraEnabled 
        public String labelPlural{get;set;}
        @AuraEnabled 
        public Boolean layoutable{get;set;}
        @AuraEnabled 
        public Boolean mergeable{get;set;}
        @AuraEnabled 
        public Boolean mruEnabled{get;set;}
        @AuraEnabled 
        public String name{get;set;}
        @AuraEnabled 
        public Boolean queryable{get;set;}
        @AuraEnabled 
        public Boolean replicateable{get;set;}
        @AuraEnabled 
        public Boolean retrieveable{get;set;}
        @AuraEnabled 
        public Boolean searchable{get;set;}
        @AuraEnabled 
        public Boolean triggerable{get;set;}
        @AuraEnabled 
        public Boolean undeletable{get;set;}
        @AuraEnabled 
        public Boolean updateable{get;set;}       
        @AuraEnabled 
        public URLWrapper urls{get;set;}
    }
    public class URLWrapper{
        @AuraEnabled 
        public String rowTemplate {get;set;}
        @AuraEnabled 
        public String defaultValues {get;set;}
        @AuraEnabled 
        public String describe {get;set;}
        @AuraEnabled 
        public String sobjectURL {get;set;}
    }
    public class ObjectWrapper{
        @AuraEnabled 
        public String Name {get;set;}
        @AuraEnabled 
        public String APIName {get;set;}
    }*/
   
}