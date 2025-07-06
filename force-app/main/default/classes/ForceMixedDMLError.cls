public class ForceMixedDMLError {
    public static void run() {
        // Insert a non-setup object
        Account acc = new Account(Name = 'Trigger Mixed DML');
        insert acc;

        // Insert a setup object (PermissionSetAssignment)
        User u = [SELECT Id FROM User WHERE Profile.Name = 'Standard User' LIMIT 1];
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Test_Mixed_DML' LIMIT 1];

        PermissionSetAssignment psa = new PermissionSetAssignment();
        psa.AssigneeId = u.Id;
        psa.PermissionSetId = ps.Id;
        insert psa; 
    }
}