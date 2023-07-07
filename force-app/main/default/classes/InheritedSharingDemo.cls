public inherited sharing class InheritedSharingDemo {

    public static Integer getAccount(){
        return [SELECT Id, Name FROM Account].size();
    }
}