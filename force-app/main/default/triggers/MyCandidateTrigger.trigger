trigger MyCandidateTrigger on Candidate__c (before insert,before update,before delete,after insert, after update,after delete, after undelete) {
    
    JobStreamC__c Mybypass=JobStreamC__c.getOrgDefaults();
    If(MybyPass.Candidate__c==true){
        return;
    }
    If(trigger.Isbefore&&Trigger.IsInsert){
        MyCandidateHandler.AgeFieldCalculation(Trigger.new);
         MyCandidateHandler.CandidateStateUpdate(Trigger.new);
    }
    If(trigger.Isbefore&&Trigger.IsUpdate){
        MyCandidateHandler.AgeFieldCalculation(Trigger.new);
         MyCandidateHandler.CandidateStateUpdate(Trigger.new);
    }
     if(Trigger.IsAfter&&Trigger.IsInsert){
        
         MyCandidateHandler.NewCandidateInfoEmail(Trigger.new,Trigger.newMap);
         MyCandidateHandler.NewCandidateNotificationInfo(Trigger.new,Trigger.newMap);
         
         For (Candidate__c cn: Trigger.New){
            if(cn.Phone__c!=null){
         MyCandidateHandler.PhoneVerification(cn.id); 
            }
           if(cn.Recent_salary_USD__c!=null){    
         MyCandidateHandler.ExchangeRateUSDtoEUR(cn.id);     
            }     
         }
     }
         
     if(Trigger.IsAfter&&Trigger.IsUpdate){
         
          MyCandidateHandler.RecruiterChangeNotificationInfo(Trigger.new,Trigger.newMap,Trigger.old,Trigger.oldMap);
          For (Candidate__c cn: Trigger.New){
           if(cn.Phone__c!=null && cn.Phone__c !=Trigger.OldMap.get(cn.id).Phone__c){
         MyCandidateHandler.PhoneVerification(cn.id); 
            }
           if(cn.Recent_salary_USD__c!=null && cn.Recent_salary_USD__c!=Trigger.oldMap.get(cn.id).Recent_salary_USD__c){    
         MyCandidateHandler.ExchangeRateUSDtoEUR(cn.id);     
            }     
         }
}
     }