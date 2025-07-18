@isTest
public class ContactPhoneUpdaterTest {
    
    @testSetup
    static void setupData() {
        // Account with phone 
        Account acc1 = new Account(Name = 'Test Account 1', Phone = '1234567890');
        insert acc1;

        Contact con1 = new Contact(FirstName = 'Keerthi', LastName = 'Gala', AccountId = acc1.Id);
        insert con1;

        // Account with NO phone 
        Account acc2 = new Account(Name = 'Test Account 2');
        insert acc2;

        Contact con2 = new Contact(FirstName = 'Venu', LastName = 'Gala', AccountId = acc2.Id);
        insert con2;
    }

    @isTest
    static void testContactPhoneUpdate_WithPhone() {
        // Get the Account with phone
        Account acc = [SELECT Id FROM Account WHERE Phone != null LIMIT 1];
        Test.startTest();
        ContactPhoneUpdater.updateContactPhones(new Set<Id>{acc.Id});
        Test.stopTest();

        // Assert that contact got updated
        Contact updatedCon = [SELECT Phone FROM Contact WHERE AccountId = :acc.Id LIMIT 1];
        System.assertEquals('1234567890', updatedCon.Phone,'Contact phone should match Account phone');
    }

    @isTest
    static void testContactPhoneUpdate_WithoutPhone() {
        // This will cover the return statement
        Account acc = [SELECT Id FROM Account WHERE Phone = null LIMIT 1];
        Test.startTest();
        ContactPhoneUpdater.updateContactPhones(new Set<Id>{acc.Id});
        Test.stopTest();

        // Just assert that the contact phone remains null
        Contact con = [SELECT Phone FROM Contact WHERE AccountId = :acc.Id LIMIT 1];
        System.assertEquals(null, con.Phone,'Contact phone is null when the related Account has no phone');
    }
}

//ContactPhoneUpdater.updateContactPhones(new Set<Id>{'0015j0000145ndxAAA'});