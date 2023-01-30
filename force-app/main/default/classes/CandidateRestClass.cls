public class CandidateRestClass {
    
public static Map<string,object> ExchangeAmount(String amount){
        
        //get the api key from custom setting
        JobStreamRest__c abc = JobStreamRest__c.getOrgDefaults();
        String keyToken = abc.ExchangeRate__c; 
        system.debug('key is = '+ keyToken);
        system.debug('Euro amount is = '+ amount);
        
        string endPoint = 'https://api.apilayer.com/exchangerates_data/convert?to=EUR&from=USD&amount='+amount; 
        system.debug('end point is = '+ endPoint);
        
        HTTP h1 = new HTTP(); 
        HTTPRequest req = new HTTPRequest();
        
        
        req.setHeader('apikey',keyToken);
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        //1 object of HTTPRequest - it means we are creating single req - 
        HTTPResponse resp = h1.send(req);   //1 callout.-> 1 Response 
        
        system.debug(resp.getStatus());  //ok
        system.debug(resp.getStatusCode());  //200
        
        Map<String, object>  myRes = new Map<String, object>(); 
        
        if(resp.getStatusCode() == 200){
          system.debug(resp.getBody()); 
            
            
            myRes = (Map<String, object>) JSON.deserializeUntyped(resp.getBody());
            system.debug(myRes);
           // system.debug('Is Valid = '+ myRes.get('valid')  );
            
            
            
            return myRes; 
                
 
        }
        
        return myRes; 
        
        
}}