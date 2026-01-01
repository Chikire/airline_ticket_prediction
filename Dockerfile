FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

COPY conda-linux-64.lock /tmp/conda-linux-64.lock

USER root

# install lmodern for Quarto PDF rendering
RUN sudo apt update \
    && sudo apt install -y \
    lmodern

USER $NB_UID

# install packages from conda-linux-64.lock
RUN conda create --name base --file /tmp/conda-linux-64.lock --yes --quiet \
    && conda clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

RUN pip install deepchecks==0.18.1
