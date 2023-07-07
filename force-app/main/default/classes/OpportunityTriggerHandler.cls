public with sharing class OpportunityTriggerHandler {
    
    public static void updateOppAmountOnAcc(List<Opportunity> oppList){

        //Store All Acc Ids
        Set<Id> accIds = new Set<Id>();
        List<Account> accListToBeUpdated = new List<Account>();
        for(Opportunity opp : oppList){

            if(opp.AccountId != null){
                accIds.add(opp.AccountId);
            }
        }

        for(Account acc :  [SELECT Id, Total_Opportunity_Amount__c, (SELECT Id, Amount FROM Opportunities) FROM Account WHERE Id IN :accIds]){
            acc.Total_Opportunity_Amount__c = 0;

            for(Opportunity op : acc.Opportunities){
                if(op.Amount != null){
                    acc.Total_Opportunity_Amount__c = acc.Total_Opportunity_Amount__c + op.Amount;
                }
            }
            accListToBeUpdated.add(acc);
        }
        if(!accListToBeUpdated.isEmpty()){
            UPDATE accListToBeUpdated;
        }
    }
    
    //Learn Technocrates - YT 
	//S2 -Create trigger on opportunity that automatically update expectedRevenue field when the opportunity amount is change. ExpectedRevenue should calculate 75% of the amount.

    public static void updateExpRev75PercentOfOppAmnt(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        
        for(Opportunity opp : oppList){
            if(opp.Amount != oldMap.get(opp.Id).Amount){
                Decimal expectedRevenue = opp.Amount * 0.75;
                opp.Amount = expectedRevenue;
            }
        }
    }
    
    	//Deloitte Interview Question
    	public static void updateAccountRatingBasedOnOppAmt(List<Opportunity> oppList){
            
            Set<Id> accIds = new Set<Id>();
            
            List<Account> accToBeUpdate = new List<Account>();
            for(Opportunity opp1 : oppList){
                accIds.add(opp1.AccountId);
            }
            
            List<Account> accList = [SELECT Id, Name, Rating, (SELECT Id, Name, AccountId, Amount FROM Opportunities) FROM Account WHERE ID IN:accIds];

			for(Account acc : accList){
                for(Opportunity opp2 : acc.opportunities){
                    Account ac = new Account();
                     if(opp2.Amount >= 10000){
                        
                        ac.Name = opp2.Name;
                        ac.Active__c = 'Yes';
                        ac.Rating = 'Hot';
                        ac.Id = opp2.AccountId;
                        accToBeUpdate.add(ac);
					}   
                }   
			}

			if(!accToBeUpdate.isEmpty()){
				insert accToBeUpdate;
			}
		}	
}