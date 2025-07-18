public class UpdateAccountTotalOpportunityAmount implements Queueable {

    public Set<Id> accountIds;

    public UpdateAccountTotalOpportunityAmount(Set<Id> accountIds) {
        this.accountIds = accountIds;
    }

    public void execute(QueueableContext context) {
        UpdateAccountTotalOpportunityAmount.updateAccountTotals(accountIds);
    }

    public static void updateAccountTotals(Set<Id> accountIds) {
        Map<Id, Decimal> accountToTotalAmount = new Map<Id, Decimal>();

        // Use AggregateResult to get total Amount per Account
        List<AggregateResult> results = [
            SELECT AccountId, SUM(Amount) totalAmount
            FROM Opportunity
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ];

        for (AggregateResult r : results) {
            accountToTotalAmount.put(
                (Id) r.get('AccountId'),
                (Decimal) r.get('totalAmount')
            );
        }

        // Create list of Accounts to update
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accountToTotalAmount.keySet()) {
            accountsToUpdate.add(new Account(
                Id = accId,
                Total_Opportunity_Amount__c = accountToTotalAmount.get(accId)
            ));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}