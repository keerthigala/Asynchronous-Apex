public class ApexBatchStudy implements Database.Batchable<sObject>, Database.Stateful {
        public Integer count = 0;
    
    //Start
    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('Started');
        String query = 'SELECT Id, Name, Rating FROM Account';
        return Database.getQueryLocator(query);

    }
    
    //Execute
    public void execute(Database.BatchableContext bc, List<Account> scope)
    {
        count = count + 1;

    }
    
    //Finish
    public void finish(Database.BatchableContext bc) {
        System.debug('Finished');
        System.debug('No of batches processed: ' + count);
        
    }

    

}