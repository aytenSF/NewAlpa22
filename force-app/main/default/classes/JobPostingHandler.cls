public class JobPostingHandler  {
   
    Public Static Void JobPostingSiteDescription(List<Job_Posting__c> TN){
        Map<id,string> jobDesMap=new Map<id,string>();
        set<id> jobpostingId= new set<id>();
        
         for(Job_Posting__c job:TN){
          JobpostingId.add(job.Job_Posting_Site__c);       
         }
       
        
         List<Job_Posting_Site__c> jobPL=[Select Id,Name,URL__c,Owner.Name,isActive__c,CreatedDate 
                                   FROM Job_Posting_Site__c WHERE Id=:JobpostingId];  
          for(Job_Posting_Site__c jobP : jobPL){                         
                                              
                                               String str='Site Id: '+ jobP.Id+'\n'+
                     								      'Site Name: '+jobP.Name+ '\n'+
                                                          'Owner: '+jobP.Owner.Name+'\n'+
                     								      'URL: '+ jobP.URL__c+'\n'+
                     								      'Is Active: '+jobP.isActive__c+'\n'+
                     								      'Created on '+jobP.CreatedDate;
                     JobDesMap.put(jobP.Id,str);
}
        for(Job_Posting__c job:TN){ 
            job.Job_Posting_Site_Description__c = JobDesMap.get(job.Job_Posting_Site__c);
        }       
                                   }
    
    Public Static Void PositionDescription(List<Job_Posting__c> pTN) {
        Map<id,string> PosDesMap= new map<id,string>();
        set<id> posId= new set<id>();
        for(Job_Posting__c job:pTN) {
           posId.add(job.Position__c);
        }
   List<Position__c> jobPoL=[Select Id,Name,Owner.Name,CreatedDate,Start_Date__c,
                                   Status__c,Priority__c,Location__c,Type__c
                                   FROM Position__c WHERE Id in:posId];
        for(Position__c jobpo:jobPoL){
                              String str   	='Title: '+ jobpo.Name+'\n'+
                    						'Start Date: '+JobPo.Start_Date__c+'\n'+
                    						'Status: '+JobPo.Status__c+'\n'+
                    						'Priority: '+JobPo.Priority__c+'\n'+
                    						'Location: '+JobPo.Location__c+'\n'+
                    						'Type: '+JobPo.Type__c+'\n'+
                    						'Owner: '+JobPo.Owner.Name+'\n'+
                    						'Created Date'+JobPo.CreatedDate;
            PosDesMap.put(jobpo.id,str);
            }
        for(Job_Posting__c job:pTN) {
            job.Position_Description__c = PosDesMap.get(job.Position__c);
}
}

    }