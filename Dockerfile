FROM python:3.9

WORKDIR /app/notesapp

COPY requirements.txt /app/notesapp
RUN pip install -r requirements.txt

COPY . /app/notesapp

EXPOSE 8000

CMD python /app/notesapp/manage.py runserver 0.0.0.0:8000