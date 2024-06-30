process RHP_VALIDATION {

    // The RHP Validator will give a non-zero exit code if it 
    // determines an error in the hrdf report. We want to continue
    // and catch this error in the Samplify layer, that way we know
    // what has caused the issue
    maxForks 5
    errorStrategy 'ignore'
    label "RHP_VALIDATION"

    input: 
        val(sampleId),
        val(analysisType),
        file(hrdfFile),
        val(pubDir)
    
    output: 
        val sampleId, emit: sampleId
        val analysisType, emit: analysisType
        path "*.txt", emit: hdr
        val pubDir, emit: pubDir

    publishDir "${pubDir}", mode: 'copy', pattern: '*.txt'

    script:
    """
    set +e

    python \
        -m rhp validate hrdf \
        --analysis-type $analysisType \
        --input-file $hrdfFile \
        --json \
        > ${sampleId}.rhp_validation_file.txt
    
    cat ${sampleId}.rhp_validation_file.txt

    """
}
