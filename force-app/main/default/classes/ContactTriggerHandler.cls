public class ContactTriggerHandler {

    //Learn Technocrates - YT
    //S1 - Create Trigger on the Contact that automatically assign a defualt value to the 'Title' field when a new contact is created
    public static void updateContactTitle(List<Contact> conList){
        
        for(Contact con : conList){
            if(con.Title == null){
                con.Title = 'Default Title';
            }
        }
    }
}