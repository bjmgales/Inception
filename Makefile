all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build
down:
	@docker compose -f ./srcs/docker-compose.yml down

re:
	@docker compose -f srcs/docker-compose.yml up -d --build

clean: confirm_clean

	@docker stop $$(docker ps -qa);\
	rm -rf ~/data/wordpress_db/*;\
	rm -rf ~/data/mariadb/*;\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm srcs_mariadb;\
	docker volume rm srcs_wordpress;\

confirm_clean:
	@read -p "Are you sure you want to clean? You'll lose all containers databases. [y/N]: " yn; \
	case $$yn in \
		[Yy]* ) echo "Cleaning...";; \
	* ) echo "Cleanup aborted"; exit 1;; \
	esac

.PHONY: all re down clean confirm_clean
