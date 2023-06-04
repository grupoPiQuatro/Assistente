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
        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Identificado que você está em um pc com interface gráfica"
        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Deseja instalar a versão com interface gráfica (S/N)? (caso contrario será instalada a versão CLI)"
        read inst
        if [ \"$inst\" == \"S\" ]
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
                                        sudo docker start containerBD
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container banco de dados já iniciado"

                                        sudo docker ps | grep containerJar
                                        if [ $? -eq 0 ]
                                        then
                                                sudo docker start containerBD
                                                sudo docker exec -i ContainerJar bash -c "java-jar projeto-individual-java-jar-1.0-SNAPSHOT-jar-with-dependencies.jar"
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) container da aplicação java iniciado"
                                        fi
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
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Aqui será implementada a instalação do CLI"
        fi



else
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
                                sudo docker ps | grep containerJar
                                if [ $? -eq 0 ]
                                then
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Iniciando versão para CLI" 
                                        sleep 2
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) containers já iniciados"
                                        sleep 2
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) logando no para iniciar captura"

                                        # Criar o arquivo de Login
                                        valida=""
                                        while [[ -z "$valida" ]]; do

                                                echo insira os dados de login!
                                                login=""

                                                while [[ -z "$login" ]]; do
                                                read -p "Digite o login: " login
                                                
                                                if [[ -z "$login" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Login inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done

                                                senha=""

                                                while [[ -z "$senha" ]]; do
                                                read -p "Digite a senha: " senha
                                                
                                                if [[ -z "$senha" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Senha inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done

                                                echo $login > my_env.txt
                                                echo $senha >> my_env.txt
                                                
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) deseja prosseguir com os dados informados (S/N)"
                                                read inst
                                                if [ \"$inst\" == \"S\" ] || [ \"$inst\" == \"s\" ]
                                                then
                                                        valida="verified"
                                                else
                                                        echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Recomençando login"
                                                fi

                                        if [[ -z "$valida" ]]; then
                                                valida=""
                                        fi
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Seguindo com os dados inseridos"
                                        done

                                        unset $login
                                        unset $senha

                                        # Copiar arquivo pro container
                                        sudo docker cp ./my_env.txt ContainerJar:./my_env.txt
                                        rm app/my_env.txt

                                        sudo docker exec -i containerJar bash -c "java -jar projeto-individual-java-jar-1.0-SNAPSHOT-jar-with-dependencies.jar"
                                else
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Iniciando versão para CLI" 
                                        sleep 2
                                        cd ScriptDocker
                                        if [ $? -eq 0 ]
                                        then
                                                cd ScriptDocker/app
                                                valida=""
                                                while [[ -z "$valida" ]]; do

                                                        echo insira os dados cadastrais para login na aplicação!
                                                        login=""

                                                        while [[ -z "$login" ]]; do
                                                        read -p "Digite o login: " login
                                                        
                                                        if [[ -z "$login" ]]; then
                                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Login inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                        fi
                                                        done

                                                        senha=""

                                                        while [[ -z "$senha" ]]; do
                                                        read -p "Digite a senha: " senha
                                                        
                                                        if [[ -z "$senha" ]]; then
                                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Senha inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                        fi
                                                        done

                                                        echo $login > my_env.txt
                                                        echo $senha >> my_env.txt

                                                        setor=""

                                                        while [[ -z "$setor" ]]; do
                                                        read -p "Digite o setor: " setor
                                                        
                                                        if [[ -z "$setor" ]]; then
                                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Setor inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                        fi
                                                        done

                                                        disco=""

                                                        while [[ -z "$disco" ]]; do
                                                        read -p "Digite o tipo de disco: " disco
                                                        
                                                        if [[ -z "$disco" ]]; then
                                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) disco inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                        fi
                                                        done
                                                        
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) deseja prosseguir com os dados informados (S/N)"
                                                        read inst
                                                        if [ \"$inst\" == \"S\" ] || [ \"$inst\" == \"s\" ]
                                                        then
                                                                valida="verified"
                                                        else
                                                                echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Recomençando login"
                                                        fi

                                                if [[ -z "$valida" ]]; then
                                                        valida=""
                                                fi
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Seguindo com os dados inseridos"
                                                done

                                                echo $setor > config.txt
                                                echo $disco >> config.txt

                                                unset $login
                                                unset $senha
                                                unset $setor
                                                unset $disco

                                                cd ..
                                                
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                                                sleep 2

                                                sudo docker build -t containerjar .
                                                rm app/my_env.txt
                                                rm app/config.txt
                                                
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                                                sleep 2
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
                                        else
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Instalando versão para CLI..."

                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) nenhum container encontrado."
                                                sleep 2
                                                sudo gpasswd -a $USER docker
                                                git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                                                
                                                cd ScriptDocker/app

                                                echo insira os dados cadastrais para login na aplicação!
                                                valida=""
                                                while [[ -z "$valida" ]]; do

                                                        echo insira os dados cadastrais para login na aplicação!
                                                        login=""

                                                        while [[ -z "$login" ]]; do
                                                        read -p "Digite o login: " login
                                                        
                                                        if [[ -z "$login" ]]; then
                                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Login inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                        fi
                                                        done

                                                        senha=""

                                                        while [[ -z "$senha" ]]; do
                                                        read -p "Digite a senha: " senha
                                                        
                                                        if [[ -z "$senha" ]]; then
                                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Senha inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                        fi
                                                        done

                                                        echo $login > my_env.txt
                                                        echo $senha >> my_env.txt

                                                        setor=""

                                                        while [[ -z "$setor" ]]; do
                                                        read -p "Digite o setor: " setor
                                                        
                                                        if [[ -z "$setor" ]]; then
                                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Setor inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                        fi
                                                        done

                                                        disco=""

                                                        while [[ -z "$disco" ]]; do
                                                        read -p "Digite o tipo de disco: " disco
                                                        
                                                        if [[ -z "$disco" ]]; then
                                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) disco inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                        fi
                                                        done
                                                        
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) deseja prosseguir com os dados informados (S/N)"
                                                        read inst
                                                        if [ \"$inst\" == \"S\" ] || [ \"$inst\" == \"s\" ]
                                                        then
                                                                valida="verified"
                                                        else
                                                                echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Recomençando login"
                                                        fi

                                                if [[ -z "$valida" ]]; then
                                                        valida=""
                                                fi
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Seguindo com os dados inseridos"
                                                done

                                                echo $setor > config.txt
                                                echo $disco >> config.txt

                                                unset $login
                                                unset $senha
                                                unset $setor
                                                unset $disco

                                                cd ..

                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                                                sleep 2
                                                # sudo docker build --build-arg login=$login --build-arg senha=$senha -t containerjar .
                                                sudo docker build -t containerjar .
                                                rm app/my_env.txt
                                                rm app/config.txt

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

                        else
                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Instalando versão para CLI..."
                                cd ScriptDocker
                                if [ $? -eq 0 ]
                                then
                                        cd ScriptDocker/app
                                        valida=""
                                        while [[ -z "$valida" ]]; do

                                                echo insira os dados cadastrais para login na aplicação!
                                                login=""

                                                while [[ -z "$login" ]]; do
                                                read -p "Digite o login: " login
                                                
                                                if [[ -z "$login" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Login inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done

                                                senha=""

                                                while [[ -z "$senha" ]]; do
                                                read -p "Digite a senha: " senha
                                                
                                                if [[ -z "$senha" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Senha inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done

                                                echo $login > my_env.txt
                                                echo $senha >> my_env.txt

                                                setor=""

                                                while [[ -z "$setor" ]]; do
                                                read -p "Digite o setor: " setor
                                                
                                                if [[ -z "$setor" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Setor inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done

                                                disco=""

                                                while [[ -z "$disco" ]]; do
                                                read -p "Digite o tipo de disco: " disco
                                                
                                                if [[ -z "$disco" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) disco inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done
                                                
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) deseja prosseguir com os dados informados (S/N)"
                                                read inst
                                                if [ \"$inst\" == \"S\" ] || [ \"$inst\" == \"s\" ]
                                                then
                                                        valida="verified"
                                                else
                                                        echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Recomençando login"
                                                fi

                                        if [[ -z "$valida" ]]; then
                                                valida=""
                                        fi
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Seguindo com os dados inseridos"
                                        done

                                        echo $setor > config.txt
                                        echo $disco >> config.txt

                                        unset $login
                                        unset $senha
                                        unset $setor
                                        unset $disco

                                        cd ..
                                        
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                                        sleep 2

                                        sudo docker build -t containerjar .
                                        rm app/my_env.txt
                                        rm app/config.txt
                                        
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) iniciando banco de dados..."
                                        sleep 2
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
                                else
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) nenhum container encontrado."
                                        sleep 2
                                        sudo gpasswd -a $USER docker
                                        git clone https://github.com/grupoPiQuatro/ScriptDocker.git
                                        
                                        cd ScriptDocker/app

                                        echo insira os dados cadastrais para login na aplicação!
                                        while [[ -z "$valida" ]]; do

                                                echo insira os dados cadastrais para login na aplicação!
                                                login=""

                                                while [[ -z "$login" ]]; do
                                                read -p "Digite o login: " login
                                                
                                                if [[ -z "$login" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Login inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done

                                                senha=""

                                                while [[ -z "$senha" ]]; do
                                                read -p "Digite a senha: " senha
                                                
                                                if [[ -z "$senha" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Senha inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done

                                                echo $login > my_env.txt
                                                echo $senha >> my_env.txt

                                                setor=""

                                                while [[ -z "$setor" ]]; do
                                                read -p "Digite o setor: " setor
                                                
                                                if [[ -z "$setor" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Setor inválido. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done

                                                disco=""

                                                while [[ -z "$disco" ]]; do
                                                read -p "Digite o tipo de disco: " disco
                                                
                                                if [[ -z "$disco" ]]; then
                                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) disco inválida. Por favor, tente novamente.$(tput setaf 7)"
                                                fi
                                                done
                                                
                                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) deseja prosseguir com os dados informados (S/N)"
                                                read inst
                                                if [ \"$inst\" == \"S\" ] || [ \"$inst\" == \"s\" ]
                                                then
                                                        valida="verified"
                                                else
                                                        echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Recomençando login"
                                                fi

                                        if [[ -z "$valida" ]]; then
                                                valida=""
                                        fi
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Seguindo com os dados inseridos"
                                        done

                                        echo $setor > config.txt
                                        echo $disco >> config.txt

                                        unset $login
                                        unset $senha
                                        unset $setor
                                        unset $disco

                                        cd ..

                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                                        sleep 2
                                        # sudo docker build --build-arg login=$login --build-arg senha=$senha -t containerjar .
                                        sudo docker build -t containerjar .
                                        rm app/my_env.txt
                                        rm app/config.txt

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
                else
                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Instalando versão para CLI..."
                        
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
                        
                        cd ScriptDocker/app

                        echo insira os dados cadastrais para login na aplicação!
                        while [[ -z "$valida" ]]; do

                                echo insira os dados cadastrais para login na aplicação!
                                login=""

                                while [[ -z "$login" ]]; do
                                read -p "Digite o login: " login
                                
                                if [[ -z "$login" ]]; then
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Login inválido. Por favor, tente novamente.$(tput setaf 7)"
                                fi
                                done

                                senha=""

                                while [[ -z "$senha" ]]; do
                                read -p "Digite a senha: " senha
                                
                                if [[ -z "$senha" ]]; then
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Senha inválida. Por favor, tente novamente.$(tput setaf 7)"
                                fi
                                done

                                echo $login > my_env.txt
                                echo $senha >> my_env.txt

                                setor=""

                                while [[ -z "$setor" ]]; do
                                read -p "Digite o setor: " setor
                                
                                if [[ -z "$setor" ]]; then
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Setor inválido. Por favor, tente novamente.$(tput setaf 7)"
                                fi
                                done

                                disco=""

                                while [[ -z "$disco" ]]; do
                                read -p "Digite o tipo de disco: " disco
                                
                                if [[ -z "$disco" ]]; then
                                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) disco inválida. Por favor, tente novamente.$(tput setaf 7)"
                                fi
                                done
                                
                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) deseja prosseguir com os dados informados (S/N)"
                                read inst
                                if [ \"$inst\" == \"S\" ] || [ \"$inst\" == \"s\" ]
                                then
                                        valida="verified"
                                else
                                        echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Recomençando login"
                                fi

                        if [[ -z "$valida" ]]; then
                                valida=""
                        fi
                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Seguindo com os dados inseridos"
                        done

                        echo $setor > config.txt
                        echo $disco >> config.txt

                        unset $login
                        unset $senha
                        unset $setor
                        unset $disco
                        
                        cd ..
                        
                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                        sudo docker build -t containerjar .
                        rm app/my_env.txt
                        rm app/config.txt

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
        else
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Instalando versão para CLI..."
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
                sleep 2
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

                cd ScriptDocker/app

                echo insira os dados cadastrais para login na aplicação!
                while [[ -z "$valida" ]]; do

                        echo insira os dados cadastrais para login na aplicação!
                        login=""

                        while [[ -z "$login" ]]; do
                        read -p "Digite o login: " login
                        
                        if [[ -z "$login" ]]; then
                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Login inválido. Por favor, tente novamente.$(tput setaf 7)"
                        fi
                        done

                        senha=""

                        while [[ -z "$senha" ]]; do
                        read -p "Digite a senha: " senha
                        
                        if [[ -z "$senha" ]]; then
                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Senha inválida. Por favor, tente novamente.$(tput setaf 7)"
                        fi
                        done

                        echo $login > my_env.txt
                        echo $senha >> my_env.txt

                        setor=""

                        while [[ -z "$setor" ]]; do
                        read -p "Digite o setor: " setor
                        
                        if [[ -z "$setor" ]]; then
                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) Setor inválido. Por favor, tente novamente.$(tput setaf 7)"
                        fi
                        done

                        disco=""

                        while [[ -z "$disco" ]]; do
                        read -p "Digite o tipo de disco: " disco
                        
                        if [[ -z "$disco" ]]; then
                                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 1) disco inválida. Por favor, tente novamente.$(tput setaf 7)"
                        fi
                        done
                        
                        echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) deseja prosseguir com os dados informados (S/N)"
                        read inst
                        if [ \"$inst\" == \"S\" ] || [ \"$inst\" == \"s\" ]
                        then
                                valida="verified"
                        else
                                echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Recomençando login"
                        fi

                if [[ -z "$valida" ]]; then
                        valida=""
                fi
                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Seguindo com os dados inseridos"
                done

                echo $setor > config.txt
                echo $disco >> config.txt

                unset $login
                unset $senha
                unset $setor
                unset $disco
                
                cd ..

                echo  "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) criando imagem da aplicação......"
                sleep 2
                sudo docker build -t containerjar .
                rm app/my_env.txt
                rm app/config.txt

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