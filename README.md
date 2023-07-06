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
nextflow stargazer.nf -params-file input.yaml -profile executorLocal,instanceSizeLow,environmentContainer
```

