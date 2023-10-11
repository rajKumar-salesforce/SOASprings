public with sharing class SoaHandler {
    public static void countOfContacts(List<Contact> contactList){
        try{
            List<Account> accList = new List<Account>();
            for(Account acc : [SELECT Id,Name,( SELECT Id,Name FROM Contacts) FROM Account]){
                acc.Number_of_Contacts__c = acc.Contacts.size();
                accList.add(acc);
            }
            if(accList.size()>0){
                update accList;
            }
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
        
    }
    @AuraEnabled
    public static List<Account> recentlyCreatedAccounts(){
        try{
            return [SELECT Id,Name,Industry,Phone,AnnualRevenue,Rating
            FROM Account WITH SECURITY_ENFORCED ORDER BY CreatedDate  LIMIT 10 ];
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
            
        }
    }
    
    /* SoaHandler scc = new SoaHandler();
    scc.soaHttpCallOut();*/
    public void soaHttpCallOut() {
        try{       
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            HttpResponse response = new HttpResponse();
            
            request.setEndpoint('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
            request.setMethod('GET');
            
            // Make the HTTP request
            response = http.send(request);
            
            System.debug(response.getBody());
            
            if (response.getStatusCode() == 200) {
                Map<string,Object> bodyMap = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                for(string gets : bodyMap.keySet()){
                    System.debug(gets +':'+ bodyMap.get(gets));
                }
            } else {
                System.debug('HTTP Request Failed with status code: ' + response.getStatusCode());
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    
}