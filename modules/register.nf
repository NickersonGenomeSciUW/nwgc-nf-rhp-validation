include { send } from 'plugin/nf-samplify'

class RegistrationMessage {
    public String sampleId;
    public String analysisType;
    public String resultFile;
}

process REGISTER {

    label "RHP_REGISTRATION"

    input:
        val sampleId
        val analysisType
        path resultFilePath
        val pubDir

    exec:
    
    def msg = new RegistrationMessage(
        sampleId: sampleId, 
        analysisType: analysisType, 
        resultFile: pubDir + "/" + sampleId + ".rhp_validation_file.txt"
    )

    println msg
    send(msg, "HrdfValidationPipeline")
}