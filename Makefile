.PHONY: docker build up down api api-b db api-r

docker:
	docker compose down && docker compose build && docker compose up -d

build:
	docker compose build

up:
	docker compose up

down:
	docker compose down

api:
	docker compose up api

api-b:
	docker compose build api

api-r:
	docker compose restart api

db:
	docker compose build db && docker compose up db