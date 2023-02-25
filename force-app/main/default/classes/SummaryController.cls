public with sharing class SummaryController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getAccountContactDetails(Id selectedItemId) {
        Map<String, Object> result = new Map<String, Object>();
        List<Account> accounts = [
            SELECT Id, Name, Type, Phone, Website
            FROM Account
            WHERE Id = :selectedItemId
            WITH SECURITY_ENFORCED
        ];

        if (accounts.size() > 0) {
            result.put('account', accounts[0]);
        }

        List<Contact> contacts = [
            SELECT Id, Name, Phone, Email, Account.Name, Account.Type, Account.Phone, Account.Website
            FROM Contact
            WHERE Id = :selectedItemId
            WITH SECURITY_ENFORCED
        ];

        if (contacts.size() > 0) {
            result.put('contact', contacts[0]);
            result.put('relatedAccount', contacts[0].Account);
        }
        return result;
    }
}