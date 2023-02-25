public with sharing class AccountContactsController {
    @AuraEnabled(cacheable=true)
    public static List<AccountWrapper> getTreeData() {
        List<Account> accounts = [
            SELECT Id, Name, (SELECT Id, Name FROM Contacts)
            FROM Account
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];
        List<AccountWrapper> accountWrappers = new List<AccountWrapper>();
        for (Account acc : accounts) {
            AccountWrapper accountWrapper = new AccountWrapper();
            accountWrapper.name = acc.Id;
            accountWrapper.label = acc.Name;
            accountWrapper.expanded = true;
            List<Item> items = new List<Item>();
            for (Contact con : acc.Contacts) {
                Item item = new Item();
                item.name = con.Id;
                item.label = con.Name;
                items.add(item);
            }
            accountWrapper.items = items;
            accountWrappers.add(accountWrapper);
        }
        return accountWrappers;
    }

    public class AccountWrapper {
        @AuraEnabled
        public String Id { get; set; }
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public String label { get; set; }
        @AuraEnabled
        public Boolean expanded { get; set; }
        @AuraEnabled
        public List<Item> items { get; set; }
    }

    public class Item {
        @AuraEnabled
        public String Id { get; set; }
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public String label { get; set; }
    }
}