@isTest
public class UpdateAccountTotalOpportunityAmountTest {

    public static Id testAccountId;

    // Test setup method to create reusable test data
    @testSetup
    static void setupTestData() {
        // Create Account
        Account acc = new Account(Name = 'Test Setup Account');
        insert acc;

        // Store the account Id in a static variable
        testAccountId = acc.Id;

        // Create Opportunities for the Account
        List<Opportunity> opps = new List<Opportunity>{
            new Opportunity(
                Name = 'Opportunity 1',
                StageName = 'Prospecting',
                CloseDate = Date.today(),
                Amount = 1000,
                AccountId = acc.Id
            ),
            new Opportunity(
                Name = 'Opportunity 2',
                StageName = 'Qualification',
                CloseDate = Date.today(),
                Amount = 2000,
                AccountId = acc.Id
            )
        };

        insert opps;
    }

    // Test for the static method directly
    @isTest
    static void testUsingStaticMethod() {
        Test.startTest();
        UpdateAccountTotalOpportunityAmount.updateAccountTotals(new Set<Id>{ testAccountId });
        Test.stopTest();

        Account result = [SELECT Total_Opportunity_Amount__c FROM Account WHERE Id = :testAccountId];
        System.assertEquals(3000, result.Total_Opportunity_Amount__c, 'Total should be 3000');
    }

    // Test for the queueable version
    @isTest
    static void testUsingQueueable() {
        Test.startTest();
        System.enqueueJob(new UpdateAccountTotalOpportunityAmount(new Set<Id>{ testAccountId }));
        Test.stopTest();

        Account updatedAcc = [SELECT Total_Opportunity_Amount__c FROM Account WHERE Id = :testAccountId];
        System.assertEquals(3000, updatedAcc.Total_Opportunity_Amount__c, 'Total should be 3000');
    }
}