trigger KennyRogersContactTrigger on Contact (before insert, before update) {
    
    for (Contact c : Trigger.New) {
        // Make our callout 
        if (c.Condition__c == NULL){
            KennyRogersEinsteinCalloutClass.categorise(c.Id, c.Condition_Image__c);
            System.debug('KennyRogersContactTrigger c.Id' + c.Id);
        }
    }

}