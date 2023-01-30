public class SendDailyEmailJobPostingSite implements Schedulable{
//sending email to the owner(Job Posting Site) about the job posting and positions with html body
    public static string getTableBody(Id jpsId){
        List<Job_Posting__c> jpL=[SELECT Name,Id,Job_Posting_Site__c,Job_Posting_Site__r.Owner.Email,Job_Posting_Site__r.Name,Position__r.Name 
                                  FROM Job_Posting__c WHERE Job_Posting_Site__c =:jpsId];
       
    String htmlBody = '';

    //open table..
    htmlBody = '<table border="1" style="border-collapse: collapse"><caption>Job Posting site and related Job Posting records</caption><tr><th>Job Posting Site</th><th>Job Posting</th><th>Position</th></tr>';

    //iterate over list and output columns/data into table rows...
    for(Job_Posting__c j : jpL){

        String myJobPostingSite = j.Job_Posting_Site__r.Name; if(j.Job_Posting_Site__r.Name == null){myJobPostingSite = '[Not Provided]';}
        String myJobPosting = j.Name; if(j.Name == null){myJobPosting = '[Not Provided]';}
		String myPosition =j.Position__r.Name;if(j.Position__r.Name == null){myPosition = '[Not Provided]';}
        htmlBody += '<tr><td>' + myJobPostingSite + '</td><td>' + myJobPosting + '</td><td>' + myPosition + '</td></tr>';

    }

    //close table...
    htmlBody += '</table>';

    return htmlBody;

}
    
    public void DailyEmailFeed(){
        list<Job_Posting_Site__c>scope =[Select id,Name,Send_Email_Notification__c,Owner.Email,
                                         URL__c,isActive__c,(SELECT Id,Name From Job_Postings__r) from Job_Posting_Site__c 
                                         where Send_Email_Notification__c =True];
        
        Messaging.SingleEmailMessage[] messages = 
            new List<Messaging.SingleEmailMessage>();
        for(Job_Posting_Site__c jps:scope){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            //' </b>has been created.<p>'
            message.toAddresses = new String[] {jps.owner.Email};
                message.targetobjectid=jps.OwnerId;
            message.optOutPolicy = 'FILTER';
            message.subject = 'Daily Email';
            message.htmlbody='Job Posting Site Name: <b> ' + jps.Name +' <p>'+
                'Job Posting Site URL: <b> '+jps.URL__c+' <p>'+
                'Is Active: <b> '+jps.isActive__c+' <p>'+
                +SendDailyEmailJobPostingSite.getTableBody(jps.Id);
            message.plainTextBody = 'Below is the information about job posting sites and related job postings';
            message.saveAsActivity = false;
            messages.add(message);
            
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                         + results[0].errors[0].message);
        }
        
    }
    public void execute(schedulableContext context){
        SendDailyEmailJobPostingSite s =new SendDailyEmailJobPostingSite();  
    
}

}