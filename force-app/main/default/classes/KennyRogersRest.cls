@RestResource(urlMapping='/SkinCondition/*')
global with sharing class KennyRogersRest {
  
    @HttpPost
    //global static String doPost() {
    global static String doPost(String base64) {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String myResult = '';
        
        // Get Einstein dataset from end of URI
        String datasetName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
    
        // App Implemetation (need to have base64 passed in)
        String myTmp = base64.replace('data:image/jpeg;base64,', '');
        Blob fileBlob = EncodingUtil.base64Decode(myTmp);
        
        // Curl Implementation
        //Blob fileBlob = req.requestBody;
        
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
        return myResult;
    }
  
}