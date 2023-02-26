@isTest
private class SummaryControllerTest {
    @isTest
    static void testGetAccountContactDetails() {
        Account testAccount = new Account(Name = 'Test Account', Type = 'Customer');
        insert testAccount;

        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test@test.com',
            AccountId = testAccount.Id
        );
        insert testContact;

        Map<String, Object> result = SummaryController.getAccountContactDetails(testContact.Id);

        System.assertEquals(testAccount.Id, ((Account) result.get('relatedAccount')).Id);
        System.assertEquals(testContact.Id, ((Contact) result.get('contact')).Id);
    }
}