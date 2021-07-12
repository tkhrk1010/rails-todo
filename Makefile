## 引数なしでmakeを実行するときはhelpを呼び出す
.DEFAULT_GOAL := help

build: ## コンテナをbuildする
	@printf '\033[34m%s\033[m\n' 'docker-compose build --no-cache'
	@docker-compose build --no-cache

up: ## コンテナを起動する
	@printf '\033[34m%s\033[m\n' 'docker-compose up -d'
	@docker-compose up -d

down: ## コンテナを終了する
	@printf '\033[34m%s\033[m\n' 'docker-compose down'
	@docker-compose down

restart: down up ## コンテナを再起動する

rebuild: down build up ## コンテナをrebulidする

ls: ## コンテナの起動確認
	@printf '\033[34m%s\033[m\n' 'docker container ls'
	@docker container ls

bash: ## sh
	@printf '\033[34m%s\033[m\n' 'bash'
	@docker-compose run api bash

bundle: ## bundle install
	@printf '\033[34m%s\033[m\n' 'bundle install --jobs 4 --retry 3 --path vendor/bundle'
	@docker-compose run api bundle install --jobs 4 --retry 3 --path vendor/bundle

migrate: ## migration
	@printf '\033[34m%s\033[m\n' 'bundle exec rake db:migrate'
	@docker-compose run api bundle exec rake db:migrate

rails-c: ## rails c
	@printf '\033[34m%s\033[m\n' 'rails c'
	@docker-compose run api rails c

lint: ## rubocop
	@printf '\033[34m%s\033[m\n' 'bundle exec rubocop -A .'
	@docker-compose run api bundle exec rubocop -A .

rspec: ## rubocop
	@printf '\033[34m%s\033[m\n' 'bundle exec rspec spec/'
	@docker-compose run api bundle exec rspec spec/

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

