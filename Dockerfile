FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

COPY conda-linux-64.lock /tmp/conda-linux-64.lock

USER root

# install lmodern for Quarto PDF rendering
RUN sudo apt update \
    && sudo apt install -y lmodern texlive texlive-luatex

USER $NB_UID

RUN mamba update --quiet --file /tmp/conda-linux-64.lock \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

RUN pip install altair_ally==0.1.1 deepchecks==0.19.1 pandera==0.27.0 vegafusion==2.0.3 \
                vegafusion-python-embed==1.6.9 vl-convert-python==1.8.0 matplotlib==3.10.7 quarto-cli==1.8.26
