#!/bin/bash
PURPLE='0;35'
NC='\033[0m' 
VERSAO=11
shopt -s nocasematch
clear
echo "$(tput setaf 6)"
echo "                       _  _                         _             _"
echo "  /\/\\    ___   _ __  (_)| |_  ___   _ __    /\/\  (_) _ __    __| |"
echo " /    \\  / _ \\ | '_ \\ | || __|/ _ \\ | '__|  /    \\ | || '_ \\  / _\` |"
echo "/ /\/\ \| (_) || | | || || |_| (_) || |    / /\/\ \| || | | || (_| |"
echo "\/    \/ \___/ |_| |_||_| \__|\___/ |_|    \/    \/|_||_| |_| \__,_|"
echo "$(tput sgr0)"
echo ""
sleep 1
echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Olá, serei seu assistente para instalação da aplicação!"
sleep 3

echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Iniciando instalação..."
sleep 2

cd ~/Desktop
if  [ $? -eq 0 ]
then
        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Instalando versão para Desktop..."
        sleep 3
        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) verificando se o docker está instalado..."
        sleep 2
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
                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container banco de dados já iniciado"
                        else
                                cd cd ScriptDocker
                                if [ $? -eq 0 ]
                                then
                                        cd ScriptDocker
                                        git checkout arquitetura1
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                                        sleep 2
                                        sg docker -c '
                                        docker compose up -d
                                        '
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container do banco iniciado!!"
                                        sleep 2
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) tabelas criadas"
                                        cd ..
                                else
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) nenhum container de banco de dados encontrado."
                                        sleep
                                        sudo gpasswd -a $USER docker
                                        git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                                        cd ScriptDocker
                                        git checkout arquitetura1
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                                        sleep 2
                                        sg docker -c '
                                        docker compose up -d
                                        '
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container do banco iniciado!!"
                                        sleep 2
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) tabelas criadas"
                                        cd ..
                                fi
                        fi
                else
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) instalando docker compose..."
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) atualizando pacotes da maquina..."
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
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) docker compose instalado"
                docker compose version
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) clonando repositorio do banco ..."
                sleep 2
                git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                cd ScriptDocker
                git checkout arquitetura1
                sg docker -c '
                docker compose up -d
                '
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container do banco iniciado!!"
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) tabelas criadas"
                cd ..
                fi
        else
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) instalando o docker..."
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) atualizando pacotes da maquina..."
                sleep 1
                sudo apt-get update && sudo apt upgrade -y
                sudo apt install docker.io -y
                sleep 2
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo gpasswd -a $USER docker
                # sudo newgrp docker
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) docker instalado consucesso!!"
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) instalando docker compose..."
                sleep 2
                sudo apt-get install ca-certificates curl gnupg
                sudo apt-get install docker-compose-plugin
                DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
                sudo mkdir -p $DOCKER_CONFIG/cli-plugins
                sudo curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
                sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) docker compose instalado"
                docker compose version
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) clonando repositorio do banco..."
                sleep 2
                git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                cd ScriptDocker
                git checkout arquitetura1
                sleep 2
                sg docker -c '
                docker compose up -d
                '
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container do banco iniciado!!"
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) tabelas criadas"
                cd ..
        fi

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


else
        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Instalando versão para CLI..."
        sleep 2
        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) verificando se o docker está instalado..."
        sleep 2
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
                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container banco de dados já iniciado"
                        else
                                cd cd ScriptDocker
                                if [ $? -eq 0 ]
                                then
                                        cd ScriptDocker
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                                        sleep 2
                                        
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                                        sudo docker build -t containerjar .
                                        sleep 2
                                        sg docker -c '
                                        docker compose up -d
                                        '
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container do banco iniciado!!"
                                        sleep 2
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) tabelas criadas"
                                        cd ..
                                else
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) nenhum container de banco de dados encontrado."
                                        sleep 2
                                        sudo gpasswd -a $USER docker
                                        git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                                        cd ScriptDocker
                                        
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                                        sleep 2
                                        sudo docker build -t containerjar .

                                        sleep 2
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                                        sg docker -c '
                                        docker compose up -d
                                        '
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container do banco iniciado!!"
                                        sleep 2
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) tabelas criadas"
                                        cd ..
                                fi
                        fi
                else
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) instalando docker compose..."
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) atualizando pacotes da maquina..."
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
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) docker compose instalado"
                docker compose version
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) clonando repositorio do banco ..."
                sleep 2
                git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                cd ScriptDocker
                
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                sudo docker build -t containerjar .
                sleep 2

                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                sg docker -c '
                docker compose up -d
                '
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container do banco iniciado!!"
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) tabelas criadas"
                cd ..
                fi
        else
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) instalando o docker..."
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) atualizando pacotes da maquina..."
                sleep 1
                sudo apt-get update && sudo apt upgrade -y
                sudo apt install docker.io -y
                sleep 2
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo gpasswd -a $USER docker
                # sudo newgrp docker
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) docker instalado consucesso!!"
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) instalando docker compose..."
                sleep 2
                sudo apt-get install ca-certificates curl gnupg
                sudo apt-get install docker-compose-plugin
                DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
                sudo mkdir -p $DOCKER_CONFIG/cli-plugins
                sudo curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
                sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) docker compose instalado"
                docker compose version
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) clonando repositorio do banco..."
                sleep 2
                git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                cd ScriptDocker

                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                sleep 2
                sudo docker build -t containerjar .
                sleep 2

                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                sg docker -c '
                docker compose up -d
                '
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container do banco iniciado!!"
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) tabelas criadas"
                cd ..
                sleep 2
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Instalação concluida!"
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Verifique se a aplicação está funcionando."
        fi
fi