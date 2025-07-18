public class CloseOverdueOpportunitiesBatch implements Database.Batchable<SObject>, Database.Stateful {

    public Integer totalClosed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Name, StageName, CloseDate
            FROM Opportunity
            WHERE IsClosed = FALSE AND CloseDate < TODAY
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        for (Opportunity opp : scope) {
            opp.StageName = 'Closed Lost';
        }
        update scope;
        totalClosed += scope.size();
    }

    public void finish(Database.BatchableContext bc) {
        // Get email address from custom label
        String email = Label.Automation;

        // Send email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { email });
        mail.setSubject('Overdue Opportunities Batch Completed');
        mail.setPlainTextBody('Batch has completed. Total overdue opportunities closed: ' + totalClosed);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
//String cron = '0 30 21 ? * SUN'; // Every Sunday at 9:30 PM
//System.schedule('CloseOverdueOpportunitiesSchedule', cron, new CloseOverdueOpportunitiesScheduler());