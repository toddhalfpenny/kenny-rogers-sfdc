trigger KennyRogersContactTrigger on Contact (before insert, before update) {
    
    for (Contact c : Trigger.New) {
        // Make our callout 
        if (c.Condition__c == NULL){
            KennyRogersEinsteinCalloutClass.categorise(c.Id);
            System.debug('KennyRogersContactTrigger c.Id' + c.Id);
        }
    }

}