public class KennyRogersEinsteinCalloutClass {
    @future(callout=true)
    public static void categorise(String id) {
        System.debug('KennyRogersEinsteinCalloutClass id => ' + id);

        String myResult = '';
        String datasetName = 'Moles5';
        Blob fileBlob = EncodingUtil.base64Decode('abc');
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
                	myResult = probability.label + '::' + probability.probability;
                }
                //return dataset.Name;
            }
        }        

        System.debug('KennyRogersEinsteinCalloutClass myResult => ' + myResult);
        Contact contactToUpdate = [SELECT Id, Name FROM Contact WHERE Id=:id];
        System.debug('KennyRogersEinsteinCalloutClass myResult => ' + contactToUpdate.Name);
        contactToUpdate.Condition__c = 'Freckles';
        update contactToUpdate;
    }
}
