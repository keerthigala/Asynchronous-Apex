public class ContactPhoneUpdater {
    @future
    public static void updateContactPhones(Set<Id> accountIds) {
        List<Contact> contactsToUpdate = new List<Contact>();

        // Loop through each account
        for (Account acc : [SELECT Id, Phone FROM Account WHERE Id IN :accountIds AND Phone != null]) {
            // Query contacts for each account inside loop
            for (Contact con : [SELECT Id FROM Contact WHERE AccountId = :acc.Id]) {
                con.Phone = acc.Phone;
                contactsToUpdate.add(con);
            }
        }

        // Update all collected contacts
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}