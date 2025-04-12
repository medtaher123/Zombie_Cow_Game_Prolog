FROM swipl:latest

WORKDIR /app
COPY . .

CMD ["swipl", "-s", "main.pl", "-g", "jeu."]
