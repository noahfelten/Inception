COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/nofelten/data

all:
	@echo "Création des dossiers de persistance..."
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	@echo "Lancement de l'infrastructure Inception..."
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	@echo "Arrêt des conteneurs..."
	docker compose -f $(COMPOSE_FILE) down

clean:
	@echo "Arrêt et suppression des conteneurs, réseaux et volumes virtuels..."
	docker compose -f $(COMPOSE_FILE) down -v

fclean: clean
	@echo "Nettoyage complet de Docker et des données locales..."
	docker system prune -af
	sudo rm -rf $(DATA_PATH)/wordpress/*
	sudo rm -rf $(DATA_PATH)/mariadb/*

re: fclean all

.PHONY: all down clean fclean re
