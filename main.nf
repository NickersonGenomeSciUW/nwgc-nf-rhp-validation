include { RHP_VALIDATION } from './modules/rhp_validation.nf'
include { REGISTER } from './modules/register.nf'

workflow {
    NwgcCore.init(params)

    def sample = Channel.fromPath(params.input_csv)
            .splitCsv(header:true)
            .map{ row ->
                String id = row.id
                String analysisType = row.analysisType
                def hrdfFile = file(row.hrdfFile)
                return tuple(id, analysisType, hrdfFile)
            }

    RHP_VALIDATION(sample)
    REGISTER(RHP_VALIDATION.out)
}

workflow.onError {
    NwgcCore.error(workflow)
}

workflow.onComplete {
    NwgcCore.processComplete(workflow)
}
