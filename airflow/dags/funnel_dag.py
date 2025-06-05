from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

default_args = {
    'owner': 'lokesh',
    'start_date': datetime(2024, 1, 1),
}

with DAG(
    dag_id='lead_to_order_dbt_pipeline',
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
) as dag:

    dbt_seed = BashOperator(
        task_id='dbt_seed',
        bash_command='cd /opt/airflow/dbt && dbt seed --profiles-dir .'
    )

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='cd /opt/airflow/dbt && dbt run --profiles-dir .'
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='cd /opt/airflow/dbt && dbt test --profiles-dir .'
    )

    dbt_seed >> dbt_run >> dbt_test
