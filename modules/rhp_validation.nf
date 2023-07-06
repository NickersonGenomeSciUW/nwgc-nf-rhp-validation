process RHP_VALIDATION {

    // maxForks 3

    // The RHP Validator will give a non-zero exit code if it 
    // determines an error in the hrdf report. We want to continue
    // and catch this error in the Samplify layer, that way we know
    // what has caused the issue
    errorStrategy 'ignore'

    publishDir "hdr", mode: 'link', pattern: '*.txt'

    input: 
        tuple (
            val(id),
            val(analysisType),
            file(hrdfFile)
        )
    
    output: 
        path "*.txt", emit: hdr
        val id, emit: id

    exec:
    NwgcCore.publishMessage(workflow, "Starting for sample " + id, session)

    script:
    """
    set +e

    python \
        -m rhp validate hrdf \
        --analysis-type $analysisType \
        --input-file $hrdfFile \
        --json \
        > ${id}.rhp_validation_file.txt

    exit 0
    """
}