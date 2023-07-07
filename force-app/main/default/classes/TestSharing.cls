@IsTest
public with sharing class TestSharing {

    @IsTest(seeAllData=true)
    public static void showSharing(){

        user u = [SELECT Id FROM User Where Email = 'integration@example.com'];
        System.runAs(u){
            System.debug('Without Sharing : ' + WithoutSharingDemo.getAccount());
            System.debug('With Sharing : ' + WithSharingDemo.getAccount());
            System.debug('Without Inherited Sharing : ' + WithoutSharingDemo.callInheritedSharingClass());
            System.debug('With Inherited Sharing : ' + WithSharingDemo.callInheritedSharingClass());
        }
    }
}