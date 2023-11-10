# Base imgae
ARG BASE_CONTAINER=spark:3.5.0-scala2.12-java11-python3-ubuntu
FROM $BASE_CONTAINER as spark

# Set environment variables
ARG DELTA_SPARK_VERSION="3.0.0"
ARG DELTALAKE_VERSION="0.12.0"
ARG JUPYTERLAB_VERSION="4.0.7"
ARG PANDAS_VERSION="1.5.3"
ARG ROAPI_VERSION="0.9.0"
ARG MLFLOW_VERSION="2.8.0"
ARG NB_USER=NBuser
ARG NB_UID=1000
ARG NB_GID=1001

# Install Python libraries
USER root
RUN pip install --quiet --no-cache-dir delta-spark==${DELTA_SPARK_VERSION} \
    deltalake==${DELTALAKE_VERSION} jupyterlab==${JUPYTERLAB_VERSION} pandas==${PANDAS_VERSION} \
    roapi==${ROAPI_VERSION} mlflow==${MLFLOW_VERSION}

# Switch back to the spark user
USER ${NB_USER}

# Create a non-root user for running the notebook
FROM spark as delta
USER root

# Set environment variables for the non-root user
ARG NB_USER
ARG NB_UID
ARG NB_GID
ARG WORKDIR=/opt/spark/work-dir

# Create the non-root user
RUN groupadd -g ${NB_GID} ${NB_USER} \
    && useradd -m -s /bin/bash -N -u ${NB_UID} -g ${NB_GID} ${NB_USER}

# Install additional tools
RUN apt-get update \
    && apt-get -y install vim curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the startup script and notebook files
COPY --chown=${NB_USER} startup.sh "${WORKDIR}/"
COPY --chown=${NB_USER} . "${WORKDIR}/"

# Set permissions
RUN chown -R ${NB_USER}:${NB_GID} /home/${NB_USER}/ \
    && chown -R ${NB_USER}:${NB_GID} ${WORKDIR}

# Switch back to the non-root user
USER ${NB_USER}

# Set the working directory
WORKDIR ${WORKDIR}

# Set the entry point
ENTRYPOINT ["bash", "startup.sh"]
