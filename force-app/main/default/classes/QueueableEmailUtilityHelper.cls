public class QueueableEmailUtilityHelper implements Queueable {
    public List<Account> accountList;

    public QueueableEmailUtilityHelper(List<Account> acc) {
        accountList = acc;
    }

    public void execute(QueueableContext ctx) {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        String subject = 'Account discount update';
        String body = 'Account discount update';

        for (Account record : accountList) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String toAddress = record.Owner.Email;
            List<String> toAddresses = new List<String>{toAddress};
            mail.setToAddresses(toAddresses);
            mail.setSubject(subject);
            mail.setPlainTextBody(body);
            emailList.add(mail);
        }

        //Messaging.sendEmail(emailList);
    }
}