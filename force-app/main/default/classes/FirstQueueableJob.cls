public class FirstQueueableJob implements Queueable {
    public void execute(QueueableContext context) {
        List<Account> accList = [SELECT Id,Name From Account WHERE Name LIKE 'Test%'];
        for(Account acc : accList) {
            acc.Name = acc.Name + ' -Updated';
        }
        update accList;
        
        System.enqueueJob(new SecondQueueableJob());
        
    }
}