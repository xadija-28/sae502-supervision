FROM python:3.12-slim

WORKDIR /app

RUN pip install flask

COPY webhook.py .

EXPOSE 5001

CMD ["python", "webhook.py"]
