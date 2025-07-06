public class QueueableDemo implements Queueable {

    String strRating;

    public QueueableDemo(String rating) {
        this.strRating = rating;
    }

    public void execute(QueueableContext ctx) {
        System.debug('Started');

        List<Account> lstAccount = [
            SELECT Id, Name, Owner.Email 
            FROM Account 
            WHERE Rating = :strRating 
            LIMIT 10000
        ];

        for (Account record : lstAccount) {
            record.Discount__c = Integer.valueOf(Label.AccountDiscount);
        }

        update lstAccount;

        System.enqueueJob(new QueueableEmailUtilityHelper(lstAccount));
    }
}