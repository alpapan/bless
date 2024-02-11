== CONDA

===  INSTALL


```
conda create -y -n bless2 -c conda-forge kmc boost-cpp=1.84.0 openmpi=5.0.1 pigz zlib sparsehash=2.0.4 gcc_linux-64 gxx_linux-64 libcurl
conda activate bless2

export BLESS_PATH=`conda env list -q |grep '*'|awk '{print $3}'`

# This defines the TMP env variables, can change them here
mkdir -p $BLESS_PATH/etc/conda/activate.d/ && cp -i conda/activate.d/env_vars.sh $BLESS_PATH/etc/conda/activate.d/
mkdir -p $BLESS_PATH/etc/conda/deactivate.d/ && cp -i conda/deactivate.d/env_vars.sh $BLESS_PATH/etc/conda/deactivate.d/

make clean && make -j 4 && cp -i bless $BLESS_PATH/bin

conda deactivate
```

=== USE

Given a kmer size k and file i:

```
conda activate bless2

cd test
bash test.sh
```
