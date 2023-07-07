public without sharing class WithoutSharingDemo {
    
     public static Integer getAccount(){
        return [SELECT Id, Name FROM Account].size();
    }

    public static Integer callInheritedSharingClass(){
        return InheritedSharingDemo.getAccount();
    }
}