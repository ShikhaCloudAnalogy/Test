public with sharing class CSV_AccessToken {
    public static String getAccessToken(String CredentialList){
        try{
            if(CredentialList !=null ){
                List<uploadCSV__Credentials__c> settings = new List<uploadCSV__Credentials__c>();
                settings = (List<uploadCSV__Credentials__c>)JSON.deserialize(CredentialList, List<uploadCSV__Credentials__c>.class);
                Httprequest req = new HttpRequest();
                req.setMethod('POST');
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                String password = settings[0].uploadCSV__Password__c+settings[0].uploadCSV__Security_Token__c;
                req.setBody('grant_type=password' +
                '&client_id=' + settings[0].uploadCSV__Client_Id__c +
                '&client_secret=' + settings[0].uploadCSV__Client_Secret__c +
                '&username=' + settings[0].uploadCSV__Username__c +
                '&password=' + password );
                String endpoint = settings[0].uploadCSV__URL__c+'/services/oauth2/token';
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
                        String Access_Token;
                        while (parser.nextToken() != null) {
                            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')) {
                                parser.nextToken();
                                Access_Token = parser.getText();
                            }
                        } 
                        system.debug('access token' + Access_Token);
                        return Access_Token;                       
                    }                        
                } catch (system.CalloutException e) {
                    system.debug('error' + e);
                }
            }              
        }
        catch(Exception ex) {
            System.debug('Error'+ex.getMessage());
        }
        return null;
    } 
}