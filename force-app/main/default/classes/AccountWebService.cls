public class AccountWebService {
   public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    
    public static void getAccount(Id accId) {

        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:Connected_App_NC/services/apexrest/Account1/' + accId);
        request.setBody('{"name" : "Safiyye","phone" : "1234567891","website" : "pathtosalesforce.com"}');
        response = http.send(request);
    System.debug(response.getstatus());
        System.debug(response.getStatusCode());
        System.debug(response.getBody());
    } 

}