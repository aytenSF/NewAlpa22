public class JobPostingSiteHandler implements schedulable{
    //Sending Email to the owner of Job Posting Site descriptions fields(about position and job posting in job posting object)
    List<Job_Posting_Site__c> TrgN=new List<Job_Posting_Site__c>();
    public JobPostingSiteHandler(List<Job_Posting_Site__c> TN){
     this.TrgN=TN;     
        
    }
    
    public void execute(SchedulableContext ctxany) {
        
        List <Messaging.SingleEmailMessage> emailList = New List <Messaging.SingleEmailMessage>();
        For(Job_Posting_Site__c j1:this.TrgN){
        EmailTemplate emailtemp =[SELECT Id,Subject,Body FROM EmailTemplate Where DeveloperName='Daily_Email_Feed_JobPosting'];
        String templateId =emailtemp.Id; 
        String whoId = j1.Createdby.Id;
        String whatId = j1.Id;
        Messaging.SingleEmailMessage email =Messaging.renderStoredEmailTemplate(templateId, whoId, whatId);
        email.setTargetObjectId(j1.CreatedById);
        email.saveAsActivity = false;
            if(j1.Send_Email_Notification__c==true){
            emailList.add(email);
        }
        }
        if(emailList.size()>0){
        Messaging.sendEmail(emailList);

        }
}
}