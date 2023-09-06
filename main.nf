include { RHP_VALIDATION } from './modules/rhp_validation.nf'
include { REGISTER } from './modules/register.nf'

workflow {
    def sample = Channel.from(params.samples)
      .map{ row ->
        String sampleId = row.id
        String analysisType = row.analysisType
        Path hrdfFile = file(row.hrdfFile)
        String pubDir = row.publishDir

        return tuple(sampleId, analysisType, hrdfFile, pubDir)
      }

    RHP_VALIDATION(sample)
    REGISTER(RHP_VALIDATION.out)
}