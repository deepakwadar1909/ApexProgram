trigger AccountTrigger on Account (before insert, After insert, before update, after update, before delete, after delete, after undelete) {

    //BracesAndSemicolons - YT - Custom Setting & IsActive Check
    /*Map<String, TriggerSettingTest__c> mapActiveCheck = TriggerSettingTest__c.getAll();
    if(mapActiveCheck.get('ActiveCheckOne').IsActive__c){
          if(Trigger.isInsert){
               if(Trigger.isBefore){
                    //AccountTriggerHandler.updateUpsellOpps(Trigger.New);
               }
          }    
    }*/
    
     if(Trigger.isInsert){
            if(Trigger.isBefore){
                //Salesforce Exclusive YT: SCENARIO-1 & 2
                AccountTriggerHandler.updateShippingAddressonAcc(Trigger.new);
                AccountTriggerHandler.updateDescription(Trigger.New);
                //S1 - BracesAndSemicolons - YT
                AccountTriggerHandler.updateUpsellOpps(Trigger.New);
            }else if(Trigger.isAfter){
                //Salesforce Exclusive YT: SCENARIO-3
                AccountTriggerHandler.insertContact(Trigger.new);
                //S2 - BracesAndSemicolons - YT
                AccountTriggerHandler.createAssoctOpp(Trigger.New);
            }
    	}
    
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            // S3 - BracesAndSemicolons - YT
            AccountTriggerHandler.updatedescrpOnAccPhoneUpdate(Trigger.New, Trigger.oldMap);
        }else if(Trigger.isAfter){
            //Salesforce Exclusive YT: SCENARIO-4
            AccountTriggerHandler.updateAccountName(Trigger.New, Trigger.oldMap);
            // S4 - BracesAndSemicolons - YT
            AccountTriggerHandler.updateRelatedOppDesc(Trigger.New, Trigger.oldMap);
            //Recursion - BracesAndSemicolons - YT
            if(!PreventRecursionOnTrigger.hasExecuted){
                PreventRecursionOnTrigger.hasExecuted = true;
                AccountTriggerHandler.accountUpdate(Trigger.New, Trigger.oldMap);
            }
            // S9 - BracesAndSemicolons - YT
            AccountTriggerHandler.updateOppStageDemo(Trigger.newMap);
        }
    }
    
    if(Trigger.isDelete){
        if(Trigger.isBefore){
            // S5 - BracesAndSemicolons - YT
            //Salesforce Exclusive YT: SCENARIO-6
            AccountTriggerHandler.cantDeleteAccount(Trigger.old, Trigger.OldMap);
        }else if(Trigger.isAfter){
            // S6 - BracesAndSemicolons - YT
            AccountTriggerHandler.deleteRelatedOpp(Trigger.OldMap);
        }
    }
    
    if(Trigger.isUndelete){
        if(Trigger.isAfter){
            AccountTriggerHandler.updateRestoredAccount(Trigger.New);
        }
    }
}