trigger OpportunityTrigger on Opportunity (before insert, After insert, before update, after update) {

    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            //OpportunityTriggerHandler.updateExpRev75PercentOfOppAmnt(Trigger.new, Trigger.oldMap);
        }else if(Trigger.isAfter){
            //OpportunityTriggerHandler.updateOppAmountOnAcc(Trigger.new);
            //OpportunityTriggerHandler.updateAccountRatingBasedOnOppAmt(Trigger.new);
        }
    }

    if(Trigger.isInsert){
        //OpportunityTriggerHandler.updateAccountRatingBasedOnOppAmt(Trigger.new);
        if(Trigger.isBefore){
            //OpportunityTriggerHandler.updateAccountRatingBasedOnOppAmt(Trigger.new);
        }else if(Trigger.isAfter){
            //OpportunityTriggerHandler.updateOppAmountOnAcc(Trigger.new);
            OpportunityTriggerHandler.updateAccountRatingBasedOnOppAmt(Trigger.new);
        }
    }
}