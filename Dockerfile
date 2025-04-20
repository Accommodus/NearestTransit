FROM nimlang/nim

RUN git config --global advice.detachedHead false
RUN apt-get update && apt-get install -y make

RUN nimble install -y nimlangserver
RUN nimble install -y https://github.com/jblindsay/kdtree
