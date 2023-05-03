FROM python:3.9.13 AS build

## virtualenv
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

## add and install requirements
RUN pip install --upgrade pip && pip install pip-tools
COPY ./requirements.txt ./
RUN pip install -r requirements.txt



FROM python:3.7 AS runtime

ENV PATH="/venv/bin:$PATH"
COPY --from=build /venv /venv

WORKDIR /app
COPY . .

CMD ["python3", "main.py"]
