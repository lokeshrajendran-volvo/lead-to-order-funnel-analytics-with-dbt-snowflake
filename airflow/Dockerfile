FROM apache/airflow:2.7.0-python3.10

USER root
RUN apt-get update && apt-get install -y gcc g++ git

USER airflow
RUN pip install dbt-core dbt-snowflake
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN airflow db init
RUN airflow users create \
    --username admin \
    --firstname admin \
    --lastname volvo \
    --role Admin \
    --email lokesh.rajendran@volvocars.com \
    --password admin