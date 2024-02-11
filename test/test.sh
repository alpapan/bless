#!/bin/bash
k=21
bless -kmerlength $k -count 2 -max_mem 10 -smpthread 10 -prefix test.$k -read test.fastq.gz
