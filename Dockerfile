FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

COPY conda-linux-64.lock /tmp/conda-linux-64.lock

USER root

# install lmodern for Quarto PDF rendering
RUN sudo apt update \
    && sudo apt install -y lmodern texlive texlive-luatex

USER root

RUN rm -rf /opt/conda && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    export PATH="/opt/conda/bin:$PATH"

RUN conda update --quiet --file /tmp/conda-linux-64.lock
RUN conda clean --all -y -f
RUN fix-permissions "${CONDA_DIR}"
RUN fix-permissions "/home/${NB_USER}"

RUN pip install altair_ally==0.1.1 deepchecks==0.19.1 pandera==0.27.0 vegafusion==2.0.3 \
                vegafusion-python-embed==1.6.9 vl-convert-python==1.8.0 matplotlib==3.10.7 quarto-cli==1.8.26
