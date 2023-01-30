@IsTest
public class CandidateTest{
    
    @IsTest
   public static void ZipCodeStateMatch(){
        Zip_Code__c zp=New Zip_Code__c();
        zp.Name='11757';
        zp.State__c='NY';
        insert zp;
       List<Candidate__c> cnList=New List<Candidate__c>();
      Candidate__c cnd=New Candidate__c();
        cnd.Name='Sila';
        cnd.Zip_Postal_Code__c='11757';
       cnList.add(cnd);
         MyCandidateHandler.CandidateStateUpdate(cnList);
        insert cnList;
       
        system.assert(cnd.State_Province__c==zp.State__c, 'State did not match');
    }
    
    

}