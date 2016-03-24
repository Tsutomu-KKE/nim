FROM tsutomu7/scientific-python

RUN apt-get update --fix-missing && \
    apt-get install -y gcc git && \
    apt-get clean && \
    cd /opt && \
    git clone -b master git://github.com/nim-lang/Nim.git && \
    cd Nim && \
    git clone -b master --depth 1 git://github.com/nim-lang/csources && \
    cd csources && sh build.sh && \
    cd .. && bin/nim c koch && \
    ./koch boot -d:release && \
    echo 'export PATH=/opt/Nim/bin:$PATH' >> /root/.bashrc && \
    rm -rf /var/lib/apt/lists/*
ADD nim.tgz /root/
EXPOSE 8888
WORKDIR /root
CMD ["sh", "-c", "jupyter notebook --ip=*"]
