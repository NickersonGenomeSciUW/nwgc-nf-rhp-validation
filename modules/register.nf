process REGISTER {

    input:
        path(hdr)
        val(id)

    exec:
    NwgcCore.publishMessage(workflow, "REGISTER BACK " + id, session)
}