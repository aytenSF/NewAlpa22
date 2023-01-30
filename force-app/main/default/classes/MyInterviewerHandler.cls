public class MyInterviewerHandler {
    Public Static Void AvoiddeletionInfoFromInterviewerRecord(List<Interviewer__c> IntTO){
         for(Interviewer__c Int1:IntTO){Int1.adderror('You are not allowed to delete an Interviewer record with position');
                                        }
    }

}