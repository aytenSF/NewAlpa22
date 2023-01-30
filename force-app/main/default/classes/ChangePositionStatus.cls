public class ChangePositionStatus implements database.Batchable<SObject> , Schedulable  { 
    
//Changing Status of the posion if it is >=last month and sending email to the owner
    public database.QueryLocator start(database.BatchableContext BC){
        return database.getQueryLocator('Select id,Status__c,Start_Date__c from Position__c where Start_Date__c <=IsLastMonth__c');
    }
    
    public void execute (Database.BatchableContext BC , list<Position__c> scope){
        
        for(Position__c p:scope){
            p.status__c = 'Closed';
        }
        update scope;
        
    }
    
    public void finish(database.BatchableContext BC){
        
       Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

message.toAddresses = new String[] {'sarslan0161@gmail.com'};
message.optOutPolicy = 'FILTER';
message.subject = 'Status Changed';
message.plainTextBody = 'One moth old Positions status is changed to Closed';
Messaging.SingleEmailMessage[] messages = 
    new List<Messaging.SingleEmailMessage> {message};
         Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
if (results[0].success) {
    System.debug('The email was sent successfully.');
} else {
    System.debug('The email failed to send: '
          + results[0].errors[0].message);
}

    }
    
    public void execute (schedulableContext context){
        ChangePositionStatus ldp = new ChangePositionStatus();
		database.executeBatch(ldp);
    }
    
    }