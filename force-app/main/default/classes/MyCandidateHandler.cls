public class MyCandidateHandler {
    public static void updatePhone(Id CanId,string canPhone){
      // #27 Create a Utility method to update phone number on Candidate. 
        List<Candidate__c> can1 =[Select Id,Phone__c FROM Candidate__c Where Id=:CanId];
        if(can1.size()>0){
        can1[0].Phone__c=canPhone;
        if(canPhone.length()==10){    
        Update can1;
        }
        Else{
          System.debug('Phone number should be 10 digits');  
        }
        }
        Else{
            System.debug('Id is not found');
        }
        }
    
    public static void AgeFieldCalculation(list<candidate__c> canTN){
      /* #28- Based on DOB we need to calculate the Age using trigger and update it on same record. 
When ever we create new Candidate record - Calculate the age and update it on Age Custom field. */

           for (candidate__c c1:canTN){
           if(c1.Date_of_Birth__c!=null){
               
           
            Integer cAge=0;
            cAge=Date.today().year()-(c1.Date_of_Birth__c).year();
               c1.Age__c=string.valueof(cAge);
           }
           if(c1.Date_of_Birth__c>Date.today()){
               c1.Date_of_Birth__c.adderror('DOB cannot be later than today!');
           }
        }      
    }
    
    Public Static Void NewCandidateInfoEmail(List<Candidate__c> CTN,Map<Id,Candidate__c> CTNM){
        
        EmailTemplate emailtemp =[SELECT Id,Subject,Body FROM EmailTemplate Where DeveloperName='Candidate_Record_Info'];
        List<Messaging.SingleEmailMessage> emailL=New List <Messaging.SingleEmailMessage>();
        
           for(Candidate__c can:CTN){
        String templateId =emailtemp.Id;
        //String whoId = can.OwnerID;
        String whatId = can.Id;
        Messaging.SingleEmailMessage email =Messaging.renderStoredEmailTemplate(templateId, null, whatId);
        email.saveAsActivity = false;
        string e =can.Owner_Email__c;
        string e1=can.RIC_Email__c;
            if(e1!=null){
        email.setToAddresses(new String[]{e,e1});
            }
            else{email.setToAddresses(new String[]{e});}
        emailL.add(email);            
        } 
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(EmailL);
    if (results[0].success) {
        System.debug('The email was sent successfully.');
    } else {
        System.debug('The email failed to send: ' + results[0].errors[0].message);
    }
    
        
    }  
    
    public static void NewCandidateNotificationInfo(list<candidate__c> canTN,Map <id,candidate__c> canTNM){
              
        
                List<CustomNotificationType > TemplateInfoDetail = [SELECT Id, DeveloperName FROM CustomNotificationType WHERE DeveloperName='New_Candidate_Notification'];
                List<Messaging.CustomNotification> newNotificationL = new List<Messaging.CustomNotification>();
                set<string> IdSet = new set<string>() ;

              for(Candidate__c c2:canTN){   //we are using each record from the list above and using it in loop
               
               Messaging.CustomNotification newNotification = new Messaging.CustomNotification();
               newNotification.setTitle('A new Candidate is created  as  '+ c2.Name);
               newNotification.setBody(' Candidate as  '  +  c2.Name + ' created by ' + c2.createdBy + ' on ' + system.today());
               newNotification.setNotificationTypeId(TemplateInfoDetail[0].Id);
               newNotification.setTargetId(c2.OwnerId);
               IdSet.add(c2.OwnerId);
               if(c2.Recruiter_In_charge__c!=null){  
                Idset.add(c2.Recruiter_In_charge__c);
                 newNotificationL.add(newNotification);      
               }
               
               }
                                try {
                                     newNotificationL[0].send(IdSet);
                   }
                                    
                                catch (Exception ex) {
                                System.debug('Notification Failed:' + ex.getMessage());
                                   }

              }
    
      public static void RecruiterChangeNotificationInfo(list<candidate__c> canTN,Map <id,candidate__c> canTNM,list<candidate__c> canTO,Map <id,candidate__c> canTOM){
                      List<Messaging.CustomNotification> newNotificationL = new List<Messaging.CustomNotification>();
                      set<string> IdSet = new set<string>() ;
                      List<CustomNotificationType > TemplateInfoDetail = [SELECT Id, DeveloperName FROM CustomNotificationType WHERE DeveloperName='Recruiter_In_Charge_Update'];

                   for(Candidate__c c3:canTN){
                 if(c3.Recruiter_In_charge__c != canTOM.get(c3.Id).Recruiter_In_charge__c ){
                 Messaging.CustomNotification newNotification = new Messaging.CustomNotification();
                 newNotification.setTitle('Recruiter is Changed for  '+ c3.Name);
                 newNotification.setBody(' You are new recruiter of Candidate   ' +  c3.Name  +   ' with Id: '  + c3.Id + ' on ' + system.today());
                 newNotification.setNotificationTypeId(TemplateInfoDetail[0].Id);
                 newNotification.setTargetId(c3.Recruiter_In_charge__c);
                     IdSet.add(c3.Recruiter_In_charge__c); 
                     newNotificationL.add(newNotification);   
                 }
               
                                   try {
                  
                  newNotificationL[0].send(IdSet);
                                  }
                                       catch (Exception ex) {
                             System.debug('Notification Failed:' + ex.getMessage());
                                   }
    }  
}
    public static void CandidateStateUpdate(list<candidate__c> canTN){
        list<Zip_Code__c> zpL= [SELECT State__c,Name FROM Zip_Code__c];
        Map<String,String> mapzip=New Map<String,String>();
        For(Zip_Code__c cnzp:zpL){
            Mapzip.put(cnzp.Name, cnzp.State__c);
        }
        For(Candidate__c cn:canTN){
            cn.State_Province__c = mapzip.get(cn.Zip_Postal_Code__c);
        }
        
    }
   @Future(Callout=True)
     public static void PhoneVerification(Id CanId){
        Candidate__c can=[SELECT Id,Phone__c,Description__c FROM Candidate__c WHERE Id=:CanId];
       Map<string,object> myMap=CandidateRest.DoRestCall(can.Phone__c);
        Boolean isValid=(Boolean) myMap.get('valid');
        String Country=(string)myMap.get('country_code');
        String Carrier=(string)myMap.get('carrier');
        can.Description__c='Phone Verification ' + '\n' + 
            'Is Phone Number Valid: '+ isValid  +'\n' +
            'Country Code: '+country+'\n'+
            'Carrier: '+Carrier+'\n';
            
        Update can;
        
    }
    @Future(Callout=True)
     public static void ExchangeRateUSDtoEUR(Id CanId){
        Candidate__c can=[SELECT Id,Recent_salary_USD__c,Recent_Salary_Euro__c FROM Candidate__c WHERE Id=:CanId];
       Map<string,object> myMap=CandidateRestClass.ExchangeAmount(string.valueof(can.Recent_salary_USD__c));
        
        can.Recent_Salary_Euro__c = (decimal)mymap.get('result');
            
        Update can;
     }

}