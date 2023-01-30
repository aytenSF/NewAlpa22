trigger MyJobPostingTrigger on Job_Posting__c (before insert,before update, before delete, after insert,after update,after delete,after undelete) {
    JobStreamC__c Mybypass=JobStreamC__c.getOrgDefaults();
    If(MybyPass.JobPosting__c==true){
        return;
    }
    
    if(Trigger.isInsert&&Trigger.IsBefore){
        
        JobPostingHandler.JobPostingSiteDescription(Trigger.new);
        JobPostingHandler.PositionDescription(Trigger.new);   
    }
    if(Trigger.isInsert&&Trigger.IsAfter){
        
        
    }
    if(Trigger.IsUpdate&&Trigger.IsBefore){
     
    }
    if(Trigger.IsUpdate&&Trigger.IsAfter){
       
    }
    if(Trigger.isDelete&&Trigger.IsBefore){
    
    }
    if(Trigger.isDelete&&Trigger.IsAfter){
    
    }
    if(Trigger.isUndelete&&Trigger.IsAfter){
     
    }
}