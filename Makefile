DC := docker-compose -f ./srcs/docker-compose.yml

all:
	@mkdir -p /home/mbaypara/data/wordpress
	@mkdir -p /home/mbaypara/data/mysql
	@$(DC) up -d --build

down:
	@$(DC) down

re: clean all
	@echo "Rebuild completed"


clean:
	@$(DC) down -v --remove-orphans
	@docker rmi -f $$(docker images -q)

clean-file:
	@$(DC) down -v --remove-orphans
	@docker rmi -f $$(docker images -q)
	@rm -rf /home/mbaypara/data/wordpress
	@rm -rf /home/mbaypara/data/mysql

.PHONY: all down re clean