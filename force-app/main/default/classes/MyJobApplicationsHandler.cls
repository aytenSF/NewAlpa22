public class MyJobApplicationsHandler {
    Public Static Void CountNumberofApplicationsRollupAfterInsert(List<Job_Application__c>TN,Map<Id,Job_Application__c>TNM){
        try{
        Map<Id,Position__c>myMap=NEW map<Id,Position__c>();
        Set<Id>PosId=New Set<Id>();
        for(Job_Application__c j1:TN){
            if(j1.Position__c!=null){
            PosId.Add(j1.Position__c);
            }
        }
        if(PosId.size()>0){
            for(AggregateResult agr:[SELECT Count(Id)jobcount,Position__c FROM Job_Application__c 
                                     WHERE Position__c in:PosId Group By Position__c]){
                                       Position__c p =new Position__c();
                                       p.Id=(Id)agr.get('Position__c');
                                       p.Number_of_Job_Applications__c=(Integer)agr.get('jobcount');
                                       myMap.put(p.Id,p);
                                         
                                     }
            
        }
        
        if(myMap.size()>0){
            Update myMap.values();}
        }
            catch(Exception e){
              system.debug(e.getTypeName()+' '+e.getMessage());  
            }
        }
          Public Static Void CountNumberofApplicationsRollupAfterDelete(List<Job_Application__c>TO,Map<Id,Job_Application__c>TOM){
        try{
        Map<Id,Position__c>myMap=NEW map<Id,Position__c>();
        Set<Id>PosId=New Set<Id>();
        for(Job_Application__c j1:TO){
            if(j1.Position__c!=null){
            PosId.Add(j1.Position__c);
            }
        }
        if(PosId.size()>0){
            for(AggregateResult agr:[SELECT Count(Id)jobcount,Position__c FROM Job_Application__c 
                                     WHERE Position__c in:PosId Group By Position__c]){
                                       Position__c p =new Position__c();
                                       p.Id=(Id)agr.get('Position__c');
                                       p.Number_of_Job_Applications__c=(Integer)agr.get('jobcount');
                                       myMap.put(p.Id,p);
                                         
                                     }
            
        }
        
        if(myMap.size()>0){
            Update myMap.values();}
        }
            catch(Exception e){
              system.debug(e.getTypeName()+' '+e.getMessage());  
            }
        }
   Public Static Void CountNumberofApplicationsRollupAfterUndelete(List<Job_Application__c>TN,Map<Id,Job_Application__c>TNM){
        try{
        Map<Id,Position__c>myMap=NEW map<Id,Position__c>();
        Set<Id>PosId=New Set<Id>();
        for(Job_Application__c j1:TN){
            if(j1.Position__c!=null){
            PosId.Add(j1.Position__c);
            }
        }
        if(PosId.size()>0){
            for(AggregateResult agr:[SELECT Count(Id)jobcount,Position__c FROM Job_Application__c 
                                     WHERE Position__c in:PosId Group By Position__c]){
                                       Position__c p =new Position__c();
                                       p.Id=(Id)agr.get('Position__c');
                                       p.Number_of_Job_Applications__c=(Integer)agr.get('jobcount');
                                       myMap.put(p.Id,p);
                                         
                                     }
            
        }
        
        if(myMap.size()>0){
            Update myMap.values();}
        }
            catch(Exception e){
              system.debug(e.getTypeName()+' '+e.getMessage());  
            }
   }
   Public Static Void CountNumberofApplicationsRollupAfterUpdate(List<Job_Application__c>TN,Map<Id,Job_Application__c>TNM,List<Job_Application__c>TO,Map<Id,Job_Application__c>TOM){
        try{
        Map<Id,Position__c>myMap=NEW map<Id,Position__c>();
        Set<Id>PosId=New Set<Id>();
        for(Job_Application__c j1:TN){
            if(j1.Position__c!=TOM.get(j1.id).Position__c){
            PosId.Add(j1.Position__c);
            PosId.Add(TOM.get(j1.id).Position__c);
            }
        }
        if(PosId.size()>0){
            for(AggregateResult agr:[SELECT Count(Id)jobcount,Position__c FROM Job_Application__c 
                                     WHERE Position__c in:PosId Group By Position__c]){
                                       Position__c p =new Position__c();
                                       p.Id=(Id)agr.get('Position__c');
                                       p.Number_of_Job_Applications__c=(Integer)agr.get('jobcount');
                                       myMap.put(p.Id,p);                  
                                     }   
        }
        
        if(myMap.size()>0){
            Update myMap.values();}
        }
            catch(Exception e){
              system.debug(e.getTypeName()+' '+e.getMessage());  
            } 
   }
}