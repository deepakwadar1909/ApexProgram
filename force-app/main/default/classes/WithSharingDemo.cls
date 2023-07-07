public with sharing class WithSharingDemo {
    
    public static Integer getAccount(){
        return [SELECT Id, Name FROM Account].size();
    }

    public static Integer callInheritedSharingClass(){
        return InheritedSharingDemo.getAccount();
    }
}