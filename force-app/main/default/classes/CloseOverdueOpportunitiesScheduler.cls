public class CloseOverdueOpportunitiesScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new CloseOverdueOpportunitiesBatch(), 2);
    }
}