public class AccountTriggerHandler {
    
    /* S-1 : While creating an account, if user provides billing address but not shipping address write a logic populate shipping address with billing address?*/
    public static void updateShippingAddressonAcc(List<Account> accList){
        for(Account acc: accList){
            if(acc.ShippingStreet==null && acc.ShippingState==null && acc.ShippingCity==null && acc.ShippingCountry==null && acc.ShippingPostalCode==null){
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingState = acc.BillingState;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }

            if(acc.AnnualRevenue < 1000){
                acc.addError('Annual Revenue is less than 1000');
            }
        }
    }//closing-S-1
    //S-2 : While user creating an account, If Annual Revenue provided by the user is less than 10000, then write a logic to throw an error to user.
    public static void showAnnualRevError(List<Account> accList){
        for(Account acc: accList){
            if(acc.AnnualRevenue < 1000){
                acc.addError('Annual Revenue is less than 1000');
            }
        }
    }//closing-S-2

    /* S-3 : When user created an account, write a logic to create contact with same name and associated account and contact.? */

    public static void insertContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        
        for(Account acc : accList){
            Contact cn = new Contact();
            if(acc.Name != null){
                cn.AccountId = acc.Id;
                cn.LastName = acc.Name;
                conList.add(cn);
            }
            if(!conList.isEmpty()){
                insert conList;
            }
        }
    }//closing-S-3
    
    //S-4 : When user updates account record, if user changes account name, throw an error “Account name once created cannot be modified”
    public static void updateAccountName(List<Account> newAccList, Map<Id, Account> oldMap){
        
        for(Account acc : newAccList){
            if(acc.Name != oldMap.get(acc.Id).Name && oldMap != null){
                acc.addError('Account name once created cannot be modified/changed');
            }
        }
    }//closing-S-4
    
    //S5 - BracesAndSemicolons - YT - Prevent account deletion if the account is active
    // S-6 : Active account should not be deleted.
    public static void cantDeleteAccount(List<Account> accList, Map<Id, Account> oldMap){
        
        for(Account acc : accList){
            if(acc.Active__c == 'Yes' && oldMap.get(acc.Id).Active__c == 'Yes'){
                acc.addError('You cannot delete active accounts');
            }
        }
    }//closing-S-6
    
    //Sanjay Gupta
    //1- Update Account Description
    
    public static void updateDescription(List<Account> accList){
        for(Account acc: accList){
            //if(acc.Description == null)
                acc.Description = 'Test Description';
          
        }
    }
    
    //S1 - BracesAndSemicolons - YT
    //If Account Type Customer – Direct, then I want to populate Upsell Opportunity as Yes.
    
    public static void updateUpsellOpps(List<Account> accList){
        
        for(Account acc : accList){
            if(acc.Type == 'Customer - Direct'){
                acc.UpsellOpportunity__c = 'Yes';
            }
        }
    }
    //S2 - BracesAndSemicolons - YT
    //Create associated opportunity record when account is inserted.
    
    public static void createAssoctOpp(List<Account> accList){
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acc: accList){
            Opportunity op = new Opportunity();
            
            if(acc.Name != null){
                op.Name = acc.Name;
                op.StageName = 'Prospecting';
                op.AccountId = acc.Id;
                op.CloseDate = System.today()+7;
                oppList.add(op);
            }
            if(!oppList.isEmpty()){
                INSERT oppList;
            }
        }
    }
    
    //S3 - BracesAndSemicolons - YT
    //If Account Phone is updated, update the same value in account description
    
    public static void updatedescrpOnAccPhoneUpdate(List<Account> accList, Map<Id, Account> oldMap){
        
        for(Account acc : accList){
            
            if(oldMap != null && acc.Phone != oldMap.get(acc.Id).Phone){
                acc.Description =  'Phone Number is Updated. New Phone : ' + acc.Phone;
            }
        }
    }
    
    //S4 - BracesAndSemicolons - YT
    //Update the related Opportunity’s Phone number when the Account’s phone number is updated
    
    public static void updateRelatedOppDesc(List<Account> accList, Map<Id, Account> oldMap){
        
        Map<Id, Account> accountIdtoAccMap = new Map<Id, Account>();
        for(Account acc : accList){
            if(oldMap != null && acc.Phone != oldMap.get(acc.Id).Phone){
                accountIdtoAccMap.put(acc.Id, acc);
            }
        }
        
        List<Opportunity> oppListToUpdated = new List<Opportunity>();
        for(Opportunity opp : [SELECT id, AccountId, Description FROM Opportunity WHERE AccountId IN : accountIdtoAccMap.keySet()]){
            if(accountIdtoAccMap.ContainsKey(opp.AccountId)){
                opp.Description = accountIdtoAccMap.get(opp.AccountId).Phone;
                oppListToUpdated.add(opp);
            }
        }
        
        if(!oppListToUpdated.isEmpty()){
            UPDATE oppListToUpdated;
        }
    }
   
     //S6 - BracesAndSemicolons - YT
     //When account is deleted, delete the associated opportunity record.
     
    public static void deleteRelatedOpp(Map<Id, Account> mapAccountId){
        
        List<Opportunity> oppListToBeDeleted = new List<Opportunity>();
        for(Opportunity opp : [SELECT id FROM Opportunity WHERE AccountId IN :mapAccountId.keySet()]){
            oppListToBeDeleted.add(opp);
        }
        
        if(!oppListToBeDeleted.isEmpty()){
            DELETE oppListToBeDeleted;
        }
    }
    
    //S7 - BracesAndSemicolons - YT
    //Whenever a deleted account is restored we need to set it as active.
    
    public static void updateRestoredAccount(List<Account> accList){
        
        List<Account> accToBeUpdated = new List<Account>();
        Account newAcc = new Account();
        for(Account acc : accList){
            newAcc.Id = acc.Id;
            newAcc.Active__c = 'Yes';
            accToBeUpdated.add(newAcc);
        }
        if(!accToBeUpdated.isEmpty()){
            UPDATE accToBeUpdated;
        }
    }
    
    //Recursion Trigger
    
    public static void accountUpdate(List<Account> newAccList, Map<Id, Account> oldMap){
        
        List<Account> ListOfAccToBeUpdated = new List<Account>();
        for(Account acc : newAccList){
            Account a = new Account(id = acc.Id);
            a.Description = 'Account Updated';
            ListOfAccToBeUpdated.add(a);
        }
        if(!ListOfAccToBeUpdated.isEmpty()){
            update ListOfAccToBeUpdated;
        }
    }

    //S9 - BracesAndSemicolons - YT

    public static void updateOppStageDemo(Map<Id, Account> newMap){

        List<Opportunity> oppList = new List<Opportunity>();

        Map<Id, Opportunity> oppMap = new Map<Id,Opportunity>([SELECT Id, stageName, AccountId, createdDate FROm Opportunity WHERE AccountId IN : newMap.keySet()]);

         DateTime opp30Days = System.now()-30;

        for(Opportunity opp : oppMap.values()){
            if(opp.StageName != 'Close won' && opp.CreatedDate < opp30Days){
                opp.StageName = 'Close lost';
                opp.CloseDate = System.today();
                oppList.add(opp);
            }
        }
        if(!oppList.isEmpty()){
            UPDATE oppList;
        }
    }
}//AccountTriggerHandler-Closing