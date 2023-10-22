FROM apache/airflow:slim-2.7.2-python3.9

COPY requirements.txt .

RUN pip install -r requirements.txt
