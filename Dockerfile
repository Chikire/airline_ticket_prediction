FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

USER root
RUN apt-get update && apt-get install -y wget bzip2
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh && \
    bash /miniconda.sh -b -p /opt/conda && \
    rm /miniconda.sh
ENV PATH="/opt/conda/bin:$PATH"
USER ${NB_UID}

COPY conda-linux-64.lock /tmp/conda-linux-64.lock
RUN conda update --quiet --file /tmp/conda-linux-64.lock
RUN conda clean --all -y -f
RUN fix-permissions "${CONDA_DIR}"
RUN fix-permissions "/home/${NB_USER}"
