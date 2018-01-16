public class KennyRogersEinsteinCalloutClass {
    @future(callout=true)
    public static void categorise(String id, String base64) {
        System.debug('KennyRogersEinsteinCalloutClass id => ' + id);

        String myResult = '';
        String datasetName = 'Moles5';
        Blob fileBlob = EncodingUtil.base64Decode(base64);
        // Generic from here
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService();
        EinsteinVision_Dataset[] datasets = service.getDatasets();
        for (EinsteinVision_Dataset dataset : datasets) {
            if (dataset.Name.equals(datasetName)) {
                EinsteinVision_Model[] models = service.getModels(dataset);
                EinsteinVision_Model model = models.get(0);
                myResult = model.modelId;
                EinsteinVision_PredictionResult result = service.predictBlob(model.modelId, fileBlob, '');
                if (result == NULL) {
                    myResult = 'no-results';
                } else {
                	EinsteinVision_Probability probability = result.probabilities.get(0);
        			Contact contactToUpdate = [SELECT Id, Name FROM Contact WHERE Id=:id];
                    System.debug('KennyRogersEinsteinCalloutClass Contact => ' + contactToUpdate.Name);
                    if (probability.label == 'OK') {
                    	contactToUpdate.Condition__c = 'Benign Mole';
                    }
                    // TODO - remove above once our model has proper labels
                    contactToUpdate.Condition_Likelihood__c = (probability.probability * 100);
                    update contactToUpdate;
                	myResult = probability.label + '::' + probability.probability;
                }
                //return dataset.Name;
            }
        }        
        System.debug('KennyRogersEinsteinCalloutClass myResult => ' + myResult);
    }
}