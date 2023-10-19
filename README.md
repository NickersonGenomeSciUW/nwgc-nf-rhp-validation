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
---
samples:
- id: 1247637
  analysisType: "HDRV1"
  hrdfFile: "/temp/hrdfs/UW_AoU_CVL_HRDF_HDRV1_2023-09-15-08-10-18_A980939397_22221001547_0.csv"
  publishDir: "/net/nwgc/vol1/data/processed/samples/1247637/hdr"
- id: 1247602
  analysisType: "HDRV1"
  hrdfFile: "/temp/hrdfs/UW_AoU_CVL_HRDF_HDRV1_2023-09-15-08-10-19_A826354119_22221001512_0.csv"
  publishDir: "/net/nwgc/vol1/data/processed/samples/1247602/hdr"
samplifyPluginConfig:
  rabbitHost: "burnet.gs.washington.edu"
  rabbitUser: "nf"
  rabbitPassword: "[RabbitMQ Password]"
  rabbitVirtualHost: "[Virtual_Host]"
  ssl: false


```

Run the nextflow
----------------
```shell
module load nextflow
nextflow main.nf -params-file input.yaml -profile executorLocal,instanceSizeLow,environmentContainer
```