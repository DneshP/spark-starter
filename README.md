# Apache Spark

## Overview

This repository includes two Jupyter notebooks aimed at familiarizing myself with Apache Spark and delving into hands-on practice.

1. [**spark-starter.ipynb**](spark-starter.ipynb): This notebook serves as a comprehensive guide for brushing up on the core concepts of Apache Spark. It covers fundamental Spark concepts, basic operations, and provides an introduction to Spark.

2. [**airbnbPriceRegression.ipynb**](airbnbPriceRegression.ipynb): This notebook focuses on practical application, utilizing the Airbnb dataset to make price predictions. It demonstrates the end-to-end process, including data loading, preprocessing, regression modeling with Spark, and model evaluation. MLflow is used to log the model parameters.

## Getting Started

To run the notebooks, follow these steps:

1. Ensure you have Docker and Docker Compose installed on your system.
2. If encountering port conflicts, please update the `docker-compose.yml` file accordingly.
3. Run `./run.sh` to launch the Spark environment and access the Jupyter notebooks.
4. Open your browser and navigate to the provided URL with the token to access Jupyter notebooks.

**Note:** An access token is required for Jupyter notebook access. Find the token in the logs of the container after running `./run.sh`.

## Issues and Support

If you encounter any issues or have questions, please feel free to create an issue in this repository. We welcome contributions and feedback.