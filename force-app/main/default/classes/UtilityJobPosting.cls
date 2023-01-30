public class UtilityJobPosting {
    public static void SingleEmailMessage(Id jobId){
       // #26 Coding : Create a Utility Class / Method to send an email to owner of any account record regarding the record details.(Email Templete) (Job Posting) 
       list< Job_Posting__c> j1 = [SELECT Id,CreatedBy.Email,Createdby.Name,Name,LastModifiedBy.Name,Job_Posting_Site__r.Name,Position__r.Name FROM Job_Posting__c Where Id =:JobId];
       if(j1.size()>0){
       EmailTemplate emailtemp =[SELECT Id,Subject,Body FROM EmailTemplate Where DeveloperName='Job_Posting_Record_Info'];
        String templateId =emailtemp.Id; 
       String whoId = j1[0].Createdby.Id;
        String whatId = j1[0].Id;
        Messaging.SingleEmailMessage email =Messaging.renderStoredEmailTemplate(templateId, whoId, whatId);
      //  email.setTargetObjectId(j1.CreatedById);
        email.saveAsActivity = false;
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});

        
    }
}
}