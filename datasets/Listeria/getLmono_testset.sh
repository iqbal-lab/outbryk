#!/bin/bash
ASCP=/home/zam/bin/aspera/connect/bin/ascp
PUTTY=/home/zam/bin/aspera/connect/etc/asperaweb_id_dsa.putty
THREADS=10 ## replace $THREADS with number of threads to use
OUTDIR=
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269936/SRR1269936.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5559.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269993/SRR1269993.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6257.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269905/SRR1269905.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7107.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269938/SRR1269938.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5584.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269970/SRR1269970.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5119.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269969/SRR1269969.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5112.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269943/SRR1269943.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5744.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269971/SRR1269971.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5124.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269909/SRR1269909.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7153.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269863/SRR1269863.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7478.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269950/SRR1269950.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5809.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269994/SRR1269994.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6271.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269944/SRR1269944.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5748.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269878/SRR1269878.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7694.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269879/SRR1269879.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7716.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269865/SRR1269865.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7493.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269937/SRR1269937.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5576.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269948/SRR1269948.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5797.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269862/SRR1269862.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7474.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269864/SRR1269864.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7489.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269995/SRR1269995.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6283.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269906/SRR1269906.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7121.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269910/SRR1269910.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7161.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269902/SRR1269902.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7047.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269919/SRR1269919.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6045.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269980/SRR1269980.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5410.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269929/SRR1269929.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6208.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269939/SRR1269939.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5610.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269870/SRR1269870.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7571.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269855/SRR1269855.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_9398.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269900/SRR1269900.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7020.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269911/SRR1269911.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7198.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269882/SRR1269882.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7786.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269891/SRR1269891.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7860.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269985/SRR1269985.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6870.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269984/SRR1269984.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6848.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269875/SRR1269875.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7635.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269893/SRR1269893.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7870.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269892/SRR1269892.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7866.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269992/SRR1269992.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6244.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269874/SRR1269874.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7603.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269868/SRR1269868.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7554.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269931/SRR1269931.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6232.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269857/SRR1269857.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_9402.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269965/SRR1269965.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5088.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269998/SRR1269998.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6317.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269932/SRR1269932.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5463.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269996/SRR1269996.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6305.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269964/SRR1269964.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5081.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269973/SRR1269973.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5233.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269917/SRR1269917.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6036.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269907/SRR1269907.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7133.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269935/SRR1269935.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5543.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269854/SRR1269854.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_8816.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269947/SRR1269947.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5786.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269921/SRR1269921.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6112.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269896/SRR1269896.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_6936.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269941/SRR1269941.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5686.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269867/SRR1269867.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_7534.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269968/SRR1269968.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5108.sra
$ASCP -i $PUTTY -k1 -Tr -l200m anonftp@ftp-trace.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR126/SRR1269978/SRR1269978.sra /data3/projects/outbreak_challenge/testing/listeria/FSL_R8_5318.sra

parallel --gnu -j $THREADS 'fastq-dump --split-3 --gzip {}' ::: /data3/projects/outbreak_challenge/testing/listeria/*.sra 
