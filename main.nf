include { RHP_VALIDATION } from './modules/rhp_validation.nf'

workflow {
    RHP_VALIDATION(params.sampleId, params.analysisType, params.hrdfFile, params.pubDir)
}