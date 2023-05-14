#!/bin/bash
echo Iniciando instalação...
sleep 2
echo verificando se o docker está instalado...
docker --version
if  [ $? -eq 0 ]
then
        docker compose version
        if [ $? -eq 0 ]
        then
                sudo docker ps | grep containerBD
                if [ $? -eq 0 ]
                then
                        sleep 2
                        echo container banco de dados já iniciado
                else
                        cd cd ScriptDocker
                        if [ $? -eq 0 ]
                        then
                                cd ScriptDocker
                                echo iniciando banco de dados...
                                sleep 2
                                sg docker -c '
                                docker compose up -d
                                '
                                echo container do banco iniciado!!
                                sleep 2
                                echo tabelas criadas
                                cd ..
                        else
                                echo nenhum container de banco de dados encontrado.
                                sleep
                                sudo gpasswd -a $USER docker
                                git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                                cd ScriptDocker
                                echo iniciando banco de dados...
                                sleep 2
                                sg docker -c '
                                docker compose up -d
                                '
                                echo container do banco iniciado!!
                                sleep 2
                                echo tabelas criadas
                                cd ..
                        fi
                fi
        else
            echo instalando docker compose...
            sleep 2
            echo atualizando pacotes da maquina...
            sleep 1
            sudo apt-get update && sudo apt upgrade -y
            sudo gpasswd -a $USER docker
            # newgrp docker
            sudo apt-get install ca-certificates curl gnupg
            sudo apt-get install docker-compose-plugin
            DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
            sudo mkdir -p $DOCKER_CONFIG/cli-plugins
            sudo curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
            sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
            echo docker compose instalado
            docker compose version
            sleep 2
            echo clonando repositorio do banco ...
            sleep 2
            git clone https://github.com/grupoPiQuatro/ScriptDocker.git
            echo iniciando banco de dados...
            cd ScriptDocker
            sg docker -c '
            docker compose up -d
            '
            echo container do banco iniciado!!
            sleep 2
            echo tabelas criadas
            cd ..
        fi
else
        echo instalando o docker...
        sleep 2
        echo atualizando pacotes da maquina...
        sleep 1
        sudo apt-get update && sudo apt upgrade -y
        sudo apt install docker.io -y
        sleep 2
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo gpasswd -a $USER docker
        # sudo newgrp docker
        echo docker instalado consucesso!!
        echo instalando docker compose...
        sleep 2
        sudo apt-get install ca-certificates curl gnupg
        sudo apt-get install docker-compose-plugin
        DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
        sudo mkdir -p $DOCKER_CONFIG/cli-plugins
        sudo curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
        sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
        echo docker compose instalado
        docker compose version
        echo clonando repositorio do banco ...
        sleep 2
        git clone https://github.com/grupoPiQuatro/ScriptDocker.git
        echo iniciando banco de dados...
        cd ScriptDocker
        sleep 2
        sg docker -c '
        docker compose up -d
        '
        echo container do banco iniciado!!
        sleep 2
        echo tabelas criadas
        cd ..
fi
PURPLE='0;35'
NC='\033[0m' 
VERSAO=11
	
echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Olá, serei seu assistente para instalação do Java!;"
echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Verificando aqui se você possui o Java instalado...;"
sleep 2

java -version
if [ $? -eq 0 ];
then
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) : Você já tem o java instalado!!!"
	cd Java-Jar
	if [ $? -eq 0 ];
	then
		java -jar login-screen-1.0-SNAPSHOT-jar-with-dependencies.jar
	else
		git clone https://github.com/grupoPiQuatro/Java-Jar.git
		cd Java-Jar
		java -jar login-screen-1.0-SNAPSHOT-jar-with-dependencies.jar
	fi
else
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Não foi identificado nenhuma versão do Java instalado"
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Você deseja instalar o Java (S/N)?"
	read inst
	if [ \"$inst\" == \"S\" ]
	then
		echo "Instalando o Java!"
		sleep 2
		sudo apt install zip
                curl -s "https://get.sdkman.io" | bash
       		source "/home/ubuntu/.sdkman/bin/sdkman-init.sh"
       		sdk install java 17.0.5-amzn
		cd Java-Jar
	        if [ $? -eq 0 ];
                then
                        java -jar login-screen-1.0-SNAPSHOT-jar-with-dependencies.jar
                else
                        git clone https://github.com/grupoPiQuatro/Java-Jar.git
                        cd Java-Jar
                        java -jar login-screen-1.0-SNAPSHOT-jar-with-dependencies.jar
		fi
        	echo "O java foi instalado com sucesso!"
		clear
			
	else 	
		echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Você optou por não instalar o Java por enquanto, até a próxima então!"
	fi
fi
