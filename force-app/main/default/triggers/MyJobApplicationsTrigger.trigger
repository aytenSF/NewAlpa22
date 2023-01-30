trigger MyJobApplicationsTrigger on Job_Application__c (before insert,before update, before delete, after insert,after update,after delete,after undelete) {
    JobStreamC__c Mybypass=JobStreamC__c.getOrgDefaults();
    If(MybyPass.Job_Applications__c==true){
        return;
    }
    
    if(Trigger.isInsert&&Trigger.IsBefore){
        
       
    }
    if(Trigger.isInsert&&Trigger.IsAfter){
     MyJobApplicationsHandler.CountNumberofApplicationsRollupAfterInsert(Trigger.New,Trigger.newMap);   
        
    }
    if(Trigger.IsUpdate&&Trigger.IsBefore){
     
    }
    if(Trigger.IsUpdate&&Trigger.IsAfter){
     MyJobApplicationsHandler.CountNumberofApplicationsRollupAfterUpdate(Trigger.New,Trigger.newMap,Trigger.Old,Trigger.OldMap);     
       
    }
    if(Trigger.isDelete&&Trigger.IsBefore){
    
    }
    if(Trigger.isDelete&&Trigger.IsAfter){
     MyJobApplicationsHandler.CountNumberofApplicationsRollupAfterDelete(Trigger.Old,Trigger.OldMap);  
    
    }
    if(Trigger.isUndelete&&Trigger.IsAfter){
     MyJobApplicationsHandler.CountNumberofApplicationsRollupAfterUndelete(Trigger.New,Trigger.newMap); 
     
    }
}