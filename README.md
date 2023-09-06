RHP Validation Scripts
===============

Create the singularity sif file
-------------------------------
```
run the command in the container/rhp_validation directory

make deploy
```

Build the input yaml file
-------------------------
```yaml
input_csv: /mnt/c/code/pipelines/nwgc-rhp-validation/samples.csv

rabbitHost: Matt-Richardson.local

```

Run the nextflow
----------------
```shell
module load nextflow
nextflow main.nf -params-file input.yaml -profile executorLocal,instanceSizeLow,environmentContainer
```

import pika
import ssl

credentials = pika.PlainCredentials("nf", "nf")
ssl_options = pika.SSLOptions(context, "grc-dev.gs.washington.edu")
parameters = pika.ConnectionParameters("grc-dev", 5671, "nextflow", credentials, ssl_options=ssl_options)
connection = pika.BlockingConnection(parameters)