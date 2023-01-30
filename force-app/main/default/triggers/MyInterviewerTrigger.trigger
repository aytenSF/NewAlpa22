trigger MyInterviewerTrigger on Interviewer__c (before insert,before update, before delete, after insert,after update,after delete,after undelete) {
    JobStreamC__c Mybypass=JobStreamC__c.getOrgDefaults();
    If(MybyPass.Interviewer__c==true){
        return;
    }
     if(Trigger.isDelete&&Trigger.IsAfter){
    
    MyInterviewerHandler.AvoiddeletionInfoFromInterviewerRecord(Trigger.Old);
     }

}