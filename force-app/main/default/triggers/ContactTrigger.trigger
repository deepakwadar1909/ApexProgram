trigger ContactTrigger on Contact (before insert) {

    if(Trigger.isInsert){
        if(Trigger.isBefore){
            //S1- Learn Technocrates - YT
            ContactTriggerHandler.updateContactTitle(Trigger.new);
        }
    }
}