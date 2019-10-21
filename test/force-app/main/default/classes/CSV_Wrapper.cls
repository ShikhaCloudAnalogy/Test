public with sharing class CSV_Wrapper {
    public class FieldsWrapper{
        @AuraEnabled 
        public List<FieldsWrap> fields {get;set;}
    }
    public class FieldsWrap{
        @AuraEnabled 
        public String label {get;set;}
        @AuraEnabled 
        public String name {get;set;}
    }
}