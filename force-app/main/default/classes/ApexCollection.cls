public class ApexCollection {

    public static void sObjectListDemo(){
        List<Account> accList = new List<Account>();
        
        Account acc1 = new Account(Name = 'acc203', Active__c='Yes');
        accList.add(acc1);
        
        Account acc2 = new Account();
        acc2.Name = 'acc204';
        acc2.Active__c = 'Yes';
        accList.add(acc2);
     
        insert accList;
    }
    
    public static List<String> returnDemo(){
        List<String> colors =  new List<String>();
        colors.add('Red');
        colors.add('Green');
        colors.add('Blue');
        
        return colors;
    }
    public static void apexList(){
        
        List<String> returnedValues = new List<String>();
        returnedValues = returnDemo();
        System.debug('returnedValues colors List : ' + returnedValues);
        
        List<String> colors =  new List<String>();
        colors.add('Red');
        colors.add('Green');
        colors.add('Blue');
        colors.add('Yellow');
        
        //Add (<Element Name>)
        System.debug('Colors List : ' + colors);
        
        colors.add(1, 'Black');
        
        //Add(Integer IndexPositin, <elementName> ) 
        System.debug('Colors List : ' + colors);
        
        //AddAll (<From List>): 
        List<String> colorsList2 =  new List<String>();
        colorsList2.add('White');
        colorsList2.add('Purple');
        colorsList2.add('Maroon');
        
        colors.addAll(colorsList2);
        
        System.debug('Colors List : ' + colors);
        
        //clear();
        System.debug('colorsList2 List : ' + colorsList2);
        colorsList2.clear();
        System.debug('colorsList2 List : ' + colorsList2);
        
        //clone() - copy list
      
        List<String> clonedList = new List<String>();
        clonedList = colors.clone();
        System.debug('clonedList List : ' + clonedList); 
        
   
        //contains - search element from list
        System.debug('Colors List contains: ' + colors.contains('Red'));
    } 
}