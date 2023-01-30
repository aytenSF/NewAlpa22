public class SendEmailDailytoOwnerJobPostingSite implements database.Batchable<SObject>, Schedulable{
 //sending email to the owner(Job Posting Site) about the job posting and positions without html body in batchable class
    public database.QueryLocator start(database.BatchableContext BC){
        return database.getQueryLocator('Select id,Name,Send_Email_Notification__c,Owner.Email,URL__c,isActive__c,'+
                                        '(SELECT Id,Name,Position__r.Name From Job_Postings__r) from Job_Posting_Site__c where Send_Email_Notification__c =True');
        
    }
    
    public void execute (Database.BatchableContext BC , list<Job_Posting_Site__c> scope){
        Messaging.SingleEmailMessage[] messages = 
            new List<Messaging.SingleEmailMessage>();
        for(Job_Posting_Site__c j:scope){
            
            
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            
            message.toAddresses = new String[] {j.Owner.Email};
                message.optOutPolicy = 'FILTER';
            message.subject = 'Apex Email';
            message.plainTextBody = 'Job Posting Site Name: '+j.Name +'\n' +'\n' ;
            for(Job_Posting__c w:j.Job_Postings__r){
                message.plainTextBody = message.plainTextBody + w.Name +' '+ w.Position__r.Name+'\n';   
            }
            messages.add(message);  
        }
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                         + results[0].errors[0].message);
        }
        
    }
    public void finish(database.BatchableContext BC){
        system.debug('The task is completed.');
    }
    public void execute(schedulableContext context){
        SendEmailDailytoOwnerJobPostingSite s =new SendEmailDailytoOwnerJobPostingSite();
        database.executeBatch(s);
    }
    
}