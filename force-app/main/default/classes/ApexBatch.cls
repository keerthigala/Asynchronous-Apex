public class ApexBatch implements Database.Batchable<SObject> {
    
    // Start method
    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('Started');
        String query = 'SELECT Id, Name, Rating, Status FROM Lead WHERE CreatedDate = LAST_N_DAYS:7 AND Status = \'Closed - Converted\'';
        return Database.getQueryLocator(query);
    }
    // Execute method
    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Lead> leadsToUpdate = new List<Lead>();
        
        for (Lead lead : (List<Lead>) scope) {
            lead.Status = 'Working - Contacted';
            leadsToUpdate.add(lead);
        }
        update leadsToUpdate;
        
    }
    
    
    // Finish method
    public void finish(Database.BatchableContext bc) {
        System.debug('Finished');
    }
    
    
    
    
}