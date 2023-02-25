@isTest
private class AccountContactsControllerTest {
    @isTest
    static void testGetTreeData() {
        // Create test accounts and contacts
        Account testAccount1 = new Account(Name = 'Test Account 1');
        Account testAccount2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{ testAccount1, testAccount2 };

        Contact testContact1 = new Contact(FirstName = 'Test', LastName = 'Contact 1', AccountId = testAccount1.Id);
        Contact testContact2 = new Contact(FirstName = 'Test', LastName = 'Contact 2', AccountId = testAccount1.Id);
        Contact testContact3 = new Contact(FirstName = 'Test', LastName = 'Contact 3', AccountId = testAccount2.Id);
        insert new List<Contact>{ testContact1, testContact2, testContact3 };

        // Call the getTreeData method and check the results
        Test.startTest();
        List<AccountContactsController.AccountWrapper> treeData = AccountContactsController.getTreeData();
        Test.stopTest();

        // Check that there are 2 account wrappers in the result
        System.assertEquals(2, treeData.size());

        // Check the properties of the first account wrapper
        AccountContactsController.AccountWrapper accountWrapper1 = treeData[0];
        System.assertEquals(testAccount1.Id, accountWrapper1.name);
        System.assertEquals(testAccount1.Name, accountWrapper1.label);
        System.assertEquals(true, accountWrapper1.expanded);

        // Check that there are 2 contact items in the first account wrapper
        System.assertEquals(2, accountWrapper1.items.size());
        AccountContactsController.Item item1 = accountWrapper1.items[0];
        System.assertEquals(testContact1.Id, item1.name);
        System.assertEquals(testContact1.FirstName + ' ' + testContact1.LastName, item1.label);
        AccountContactsController.Item item2 = accountWrapper1.items[1];
        System.assertEquals(testContact2.Id, item2.name);
        System.assertEquals(testContact2.FirstName + ' ' + testContact2.LastName, item2.label);

        // Check the properties of the second account wrapper
        AccountContactsController.AccountWrapper accountWrapper2 = treeData[1];
        System.assertEquals(testAccount2.Id, accountWrapper2.name);
        System.assertEquals(testAccount2.Name, accountWrapper2.label);
        System.assertEquals(true, accountWrapper2.expanded);

        // Check that there is 1 contact item in the second account wrapper
        System.assertEquals(1, accountWrapper2.items.size());
        AccountContactsController.Item item3 = accountWrapper2.items[0];
        System.assertEquals(testContact3.Id, item3.name);
        System.assertEquals(testContact3.FirstName + ' ' + testContact3.LastName, item3.label);
    }
}