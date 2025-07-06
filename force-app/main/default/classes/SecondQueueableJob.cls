public class SecondQueueableJob implements Queueable {
    public void execute(QueueableContext cxt) {
        System.debug('Execute the second Queable Job');
    }

}