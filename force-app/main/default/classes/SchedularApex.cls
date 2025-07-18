public class SchedularApex implements Schedulable {
    public void execute(SchedulableContext cxt) {
        List<Lead> lst = [SELECT Id FROM Lead WHERE Status = 'Working - Contacted'];
        Delete lst;
        //database.executeBatch(new ApexBatch(), 5);
    }

}