include { RHP_VALIDATION } from './modules/rhp_validation.nf'
// include { REGISTER } from './modules/register.nf'

workflow {
    RHP_VALIDATION(params.sampleId, params.analysisType, params.hrdfFile, params.pubDir)
}