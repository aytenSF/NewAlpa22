public class CandidateRest {
   public static Map<string,object> DoRestCall(String phNo){
        
        //get the api key from custom setting
        JobStreamRest__c abc = JobStreamRest__c.getOrgDefaults();
        String keyToken = abc.NumVerifyToken__c; 
        system.debug('key is = '+ keyToken);
        system.debug('Phone no is = '+ phNo);
        
        string endPoint = 'http://api.apilayer.com/api/validate?&number='+phNo; 
        system.debug('end point is = '+ endPoint);
        
        HTTP h1 = new HTTP(); 
        HTTPRequest req = new HTTPRequest();
        
        //req.setEndpoint('http://apilayer.net/api/validate?access_key=b19efb6912a9ba7159c47d79fe7408b9&number=+918792441859');
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
            
            // JSON is a String  - having data in key: value pair, seperated by comma.
            // three data = valid, country code, mobile type.
            myRes = (Map<String, object>) JSON.deserializeUntyped(resp.getBody());
            system.debug(myRes);
            
            
            system.debug('Is Valid = '+ myRes.get('valid')  );
            system.debug('Country = '+  myRes.get('country_code')  );
            system.debug('carrier = '+  myRes.get('carrier')  );
            
            return myRes; 
                
 
        }
        
        return myRes; 
        
        
                
    }

}