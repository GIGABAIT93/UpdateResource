#!/usr/bin/env bash
# Автор: GIGABAIT
# Контакты:
#     Дискорд - https://discord.gg/9FRVsnQ
#     ВК - https://vk.com/xxxgigabaitxxx
# Запуск скрипта:
# Перед запуском скрипта вам нaдо сделать его исполняемым для етого в терменале перейдите в каталог где лежит скрипт и выполните команду: chmod +x ./start.sh
# ./start.sh - запустит скрипт в текущей консоли. Когда сессия с этой консолю будет прервана скрипт прекратит роботу!
# ./start.sh tmux - запустит скрипт в фоне с помощью утилиты tmux. Скрипт будет работать даже если вы закроете текущую сессию. 
# ./start.sh screen - запустит скрипт в фоне с помощью утилиты screen. Скрипт будет работать даже если вы закроете текущую сессию.

# Изменять код в этом файле не рекомендовано. Все что вам нужно это запустить скрипт и следовать дальнейшей инструкции.

# Функции Первого Запускку и Настройки Конфига

outputRed(){
    echo -e '\e[31m'$1'\e[0m';  # красный
}

outputGreen(){
    echo -e '\e[32m'$1'\e[0m';  # зелёный
}

outputYellow(){
    echo -e '\e[33m'$1'\e[0m';  # желтый
}

outputBlue(){
    echo -e '\e[34m'$1'\e[0m';  # синий
}

outputPurple(){
    echo -e '\e[35m'$1'\e[0m';  # фиолетовый
}

outputCyan(){
    echo -e '\e[36m'$1'\e[0m';  # голубой
}

os_check(){
    # outputBlue "Автоматическое обнаружение операционной системы."
    if [ -r /etc/os-release ]; then
        lsb_dist="$(. /etc/os-release && echo "$ID")"
    else
        exit 1
    fi

    if [ "$lsb_dist" =  "ubuntu" ] || [ "$lsb_dist" =  "debian" ]; then
        # echo `outputYellow "OS:"; outputBlue "$lsb_dist"`
		packets_manager="apt-get"
    elif [ "$lsb_dist" =  "fedora" ] || [ "$lsb_dist" =  "centos" ] || [ "$lsb_dist" =  "rhel" ]; then
        # echo `outputYellow "OS:"; outputBlue "$lsb_dist"`
		packets_manager="yum"
    else
	    # outputBlue "Не удалось определить OS! Использую менеджер пакетов: apt-get"
	    packets_manager="apt-get"
    fi
}

eula(){
	if [ -f "eula.txt" ]; then
	sed -i s/eula=false/eula=true/g eula.txt
	else
	echo eula=true > eula.txt
	
	fi
}

port(){
	if [ -f "server.properties" ]; then
	    old_port=`grep server-port server.properties`
		if [ $old_port = server-port=0 ]; then
		    outputBlue "Введите нужен вам порт для сервера по умолчанию 25565"
			read -p "Порт: " new_port
			sed -i s/$old_port/server-port=$new_port/g server.properties
		fi
	else
	outputYellow "Введите нужен вам порт для сервера по умолчанию 25565"
	read -p "Порт?: " new_port
	echo server-port=$new_port > server.properties
	fi
}

install_wget(){
			  $packets_manager install wget git -y > /dev/null 2>&1
}

install_java(){
			 clear
			 outputBlue "Первоначальная настройка скрипта"
			 echo -e "\033[33mУстановить java-1.8.0-openjdk? Введите \033[34myes \033[33mчтоб установить или \033[34mno \033[33mчтоб отказаться и нажмите \033[34mEnter\033[0m"
			 if read -p "Ввод: " java_vaule
             then
			     if [ $java_vaule = yes ]; 
	             then
				    if [ $packets_manager = yum ]; then
				        yum install java-1.8.0-openjdk-headless -y > /dev/null 2>&1
						outputBlue "Java установлена"
					else
					    apt-get install openjdk-8-jre-headless -y > /dev/null 2>&1
						outputBlue "Java установлена"
				    fi
				 fi
             fi			 
}

paper_1_15_2(){
			 if [ $core = paper_1_15_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml				
                 echo 'core: paper 1.15.2' >> start_config.yml
		     fi
			 wget https://papermc.io/ci/job/Paper-1.15/lastSuccessfulBuild/artifact/paperclip.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
	         rm -rf cache/ > /dev/null 2>&1
			 mv paperclip.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"		 
}

paper_1_14_4(){
			 if [ $core = paper_1_14_4 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: paper 1.14.4' >> start_config.yml
             fi
			 wget https://papermc.io/ci/job/Paper-1.14/lastSuccessfulBuild/artifact/paperclip.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 rm -rf cache/ > /dev/null 2>&1
			 mv paperclip.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

paper_1_13_2(){
			 if [ $core = paper_1_13_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: paper 1.13.2' >> start_config.yml
             fi
			 wget https://papermc.io/ci/job/Paper-1.13/lastSuccessfulBuild/artifact/paperclip.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 rm -rf cache/ > /dev/null 2>&1
			 mv paperclip.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

paper_1_12_2(){
			 if [ $core = paper_1_12_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: paper 1.12.2' >> start_config.yml
             fi
			 wget https://papermc.io/ci/job/Paper/lastSuccessfulBuild/artifact/paperclip.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 rm -rf cache/ > /dev/null 2>&1
			 mv paperclip.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

paper_1_11_2(){
			 if [ $core = paper_1_11_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: paper 1.11.2' >> start_config.yml
             fi
			 wget https://papermc.io/ci/job/Paper/1104/artifact/paperclip.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 rm -rf cache/ > /dev/null 2>&1
			 mv paperclip.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

paper_1_10_2(){
			 if [ $core = paper_1_10_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: paper 1.10.2' >> start_config.yml
             fi
			 wget https://papermc.io/ci/job/Paper/916/artifact/paperclip.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 rm -rf cache/ > /dev/null 2>&1
			 mv paperclip.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

paper_1_9_4(){
			 if [ $core = paper_1_9_4 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: paper 1.9.4' >> start_config.yml
             fi
			 wget https://papermc.io/ci/job/Paper/773/artifact/paperclip.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 rm -rf cache/ > /dev/null 2>&1
			 mv paperclip.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}	
		
paper_1_8_8(){
			 if [ $core = paper_1_8_8 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: paper 1.8.8' >> start_config.yml
             fi
			 wget https://papermc.io/ci/job/Paper/443/artifact/Paperclip.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 rm -rf cache/ > /dev/null 2>&1
			 mv Paperclip.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

spigot_1_15_2(){
			 if [ $core = spigot_1_15_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: spigot 1.15.2' >> start_config.yml
             fi
			 wget https://cdn.getbukkit.org/spigot/spigot-1.15.2.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 mv spigot-1.15.2.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

spigot_1_14_4(){
			 if [ $core = spigot_1_14_4 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: spigot 1.14.4' >> start_config.yml
             fi
			 wget https://cdn.getbukkit.org/spigot/spigot-1.14.4.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 mv spigot-1.14.4.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}
			
spigot_1_13_2(){
			 if [ $core = spigot_1_13_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: spigot 1.13.2' >> start_config.yml
             fi
			 wget https://cdn.getbukkit.org/spigot/spigot-1.13.2.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 mv spigot-1.13.2.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

spigot_1_12_2(){
			 if [ $core = spigot_1_12_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: spigot 1.12.2' >> start_config.yml
             fi
			 wget https://cdn.getbukkit.org/spigot/spigot-1.12.2.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 mv spigot-1.12.2.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

spigot_1_11_2(){
			 if [ $core = spigot_1_11_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: spigot 1.11.2' >> start_config.yml
             fi
			 wget https://cdn.getbukkit.org/spigot/spigot-1.11.2.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 mv spigot-1.11.2.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

spigot_1_10_2(){
			 if [ $core = spigot_1_10_2 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: spigot 1.10.2' >> start_config.yml
             fi
			 wget https://cdn.getbukkit.org/spigot/spigot-1.10.2-R0.1-SNAPSHOT-latest.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 mv spigot-1.10.2-R0.1-SNAPSHOT-latest.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

spigot_1_9_4(){
			 if [ $core = spigot_1_9_4 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: spigot 1.9.4' >> start_config.yml
             fi
			 wget https://cdn.getbukkit.org/spigot/spigot-1.9.4-R0.1-SNAPSHOT-latest.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 mv spigot-1.9.4-R0.1-SNAPSHOT-latest.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

spigot_1_8_8(){
			 if [ $core = spigot_1_8_8 ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml	
                 echo 'core: spigot 1.8.8' >> start_config.yml
             fi
			 wget https://cdn.getbukkit.org/spigot/spigot-1.8.8-R0.1-SNAPSHOT-latest.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
			 mv spigot-1.8.8-R0.1-SNAPSHOT-latest.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"            			
}

tuinity_1_15_2(){
			  if [ $core = tuinity_1_15_2 ];
			  then
			      echo " "
			  else
			      clear
                  echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml				
                  echo 'core: tuinity 1.15.2' >> start_config.yml
		      fi
			  wget https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/artifact/tuinity-paperclip.jar > /dev/null 2>&1
			  rm $jar > /dev/null 2>&1
	          rm -rf cache/ > /dev/null 2>&1
			  mv tuinity-paperclip.jar $jar > /dev/null 2>&1
			  outputBlue "Ядро успешно загружено"
}	

BungeeCord(){
			 if [ $core = BungeeCord ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml				
                 echo 'core: BungeeCord' >> start_config.yml
		     fi
			 wget https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
	         rm -rf cache/ > /dev/null 2>&1
			 mv BungeeCord.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"
}

Travertine(){
			 if [ $core = Travertine ];
			 then
			     echo " "
			 else
			     clear
                 echo '# Ядро сервера пример paper 1.15.2 или sigot 1.15.2' >> start_config.yml				
                 echo 'core: Travertine' >> start_config.yml
		     fi
			 wget https://papermc.io/ci/job/Travertine/lastSuccessfulBuild/artifact/Travertine-Proxy/bootstrap/target/Travertine.jar > /dev/null 2>&1
			 rm $jar > /dev/null 2>&1
	         rm -rf cache/ > /dev/null 2>&1
			 mv Travertine.jar $jar > /dev/null 2>&1
			 outputBlue "Ядро успешно загружено"
}
		
core_config(){
			echo `outputYellow "Введите номер ядра которое хотите использовать например чтоб выбрать"; outputBlue "paper 1.15.2"; outputYellow "введи цыфру"; outputBlue "8"; outputYellow "и нажми"; outputBlue "Enter"`
			echo ""
			echo -e "\033[32m1) \033[33mpaper 1.8.8                  \033[32m21) \033[33mspigot 1.8.8\033[0m                   \033[32m41) \033[33mtuinity 1.15.2\033[0m"
			echo -e "\033[32m2) \033[33mpaper 1.9.4                  \033[32m22) \033[33mspigot 1.9.4\033[0m"
			echo -e "\033[32m3) \033[33mpaper 1.10.2                 \033[32m23) \033[33mspigot 1.10.2\033[0m"
			echo -e "\033[32m4) \033[33mpaper 1.11.2                 \033[32m23) \033[33mspigot 1.11.2\033[0m"
		    echo -e "\033[32m5) \033[33mpaper 1.12.2                 \033[32m25) \033[33mspigot 1.12.2\033[0m"
			echo -e "\033[32m6) \033[33mpaper 1.13.2                 \033[32m26) \033[33mspigot 1.13.2\033[0m"
			echo -e "\033[32m7) \033[33mpaper 1.14.4                 \033[32m27) \033[33mspigot 1.14.4\033[0m"
			echo -e "\033[32m8) \033[33mpaper 1.15.2                 \033[32m28) \033[33mspigot 1.15.2\033[0m"
			echo ""
			outputBlue "BungeeCord:"
			echo ""
			echo -e "\033[32m61) \033[33mTravertine 1.8 - 1.15.2\033[0m"
			echo -e "\033[32m62) \033[33mBungeeCord 1.8 - 1.15.2\033[0m"
			echo ""
			if read -p "Введите Номер: " core_vaule
            then
                if [ $core_vaule = 8 ]; 
	            then
				    paper_1_15_2
                elif [ $core_vaule = 7 ]; 
	            then
                    paper_1_14_4	            
                elif [ $core_vaule = 6 ]; 
	            then 
					paper_1_13_2
                elif [ $core_vaule = 5 ]; 
	            then 
				    paper_1_12_2
                elif [ $core_vaule = 4 ]; 
	            then 
	                paper_1_11_2
                elif [ $core_vaule = 3 ]; 
	            then 
					paper_1_10_2
                elif [ $core_vaule = 2 ]; 
	            then 
					paper_1_9_4				
                elif [ $core_vaule = 1 ]; 
	            then 
					paper_1_8_8				
                elif [ $core_vaule = 28 ]; 
	            then
				    spigot_1_15_2
                elif [ $core_vaule = 27 ]; 
	            then
                    spigot_1_14_4	            
                elif [ $core_vaule = 26 ]; 
	            then 
					spigot_1_13_2
                elif [ $core_vaule = 25 ]; 
	            then 
				    spigot_1_12_2
                elif [ $core_vaule = 24 ]; 
	            then 
	                spigot_1_11_2
                elif [ $core_vaule = 23 ]; 
	            then 
					spigot_1_10_2
                elif [ $core_vaule = 22 ]; 
	            then 
					spigot_1_9_4				
                elif [ $core_vaule = 21 ]; 
	            then 
					spigot_1_8_8
                elif [ $core_vaule = 41 ]; 
	            then 
					tuinity_1_15_2		
                elif [ $core_vaule = 61 ]; 
	            then 
					Travertine
                elif [ $core_vaule = 62 ]; 
	            then 
					BungeeCord				
				else
				    outputRed "Неверное значения перезапустите скрипт"
	                rm -rf start_config.yml > /dev/null 2>&1
					exit
	            fi
            else
				outputRed "Неверное значения перезапустите скрипт"
	            rm -rf start_config.yml > /dev/null 2>&1
			    exit
            fi
}

reset_config(){
			echo -e "\033[33mЧтоб сбросить настройки скрипат введи цыфру \033[34m1 \033[33mи нажми \033[34mEnter \033[33mв течении 5 секунд\033[0m";
			read -t 5 -p "Ввод: " reset
            if [ $reset = 1 ]; 
	        then 
	            rm -rf start_config.yml > /dev/null 2>&1
			    outputYellow "Настройки скрпита успешно сброшено! Чтоб запустить скрипт и приступить к настройке введите команду:"
				outputBlue "$0"
				exit					
	        else
	            clear
	        fi
}

autoupdate_core(){
			    echo -e "\033[33mАвтообновления ядра при рестарте сервера? Введите \033[34myes \033[33mчтоб включить или \033[34mno \033[33mчтоб отключить и нажмите \033[34mEnter\033[0m"
			    if read -p "Ввод: " autoupdate_vaule
                then
			        if [ $autoupdate_vaule = yes ]; 
	                then
						echo '# Автообновления ядра при рестарте сервера true - включено false - отключено' >> start_config.yml
	                    echo 'autoupdate: true' >> start_config.yml						
					else
						echo '# Автообновления ядра при рестарте сервера true - включено false - отключено' >> start_config.yml
	                    echo 'autoupdate: false' >> start_config.yml
				    fi
                fi					
}

remove_logs(){
			    echo -e "\033[33mУдалять папки logs при каждом рестарте сервера? Введите \033[34myes \033[33mчтоб включить или \033[34mno \033[33mчтоб отключить и нажмите \033[34mEnter\033[0m"
			    if read -p "Ввод: " logs_vaule
                then
			        if [ $logs_vaule = yes ]; 
	                then
	                    echo '# Удаления папки logs при каждом рестарте сервера true - включено false - отключено' >> start_config.yml
	                    echo 'del_logs: true' >> start_config.yml
					else
	                    echo '# Удаления папки logs при каждом рестарте сервера true - включено false - отключено' >> start_config.yml
	                    echo 'del_logs: false' >> start_config.yml
				    fi
                fi					
}

algoritm_core(){
              java_version=`java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1`
			  total_ram=`free -g | grep Mem: | grep -Eo '[0-9]{1,1000}' | head -n1` 
			  if [ $java_version -gt 10 ]; # Больше 10
			  then # java 11+
			      echo `outputBlue "Количество оперативной память сервера ="; outputYellow "$total_ram"`
				  outputYellow "Введите количество гигабайт которое вы хотите выделить на это ядро(только цыфры)"
			      if read -p "Количество?: " ram
				  then
				  	outputYellow "Выбор алгоритма запуска сервера:"
				  	echo `outputGreen "1)"; outputYellow "Алгоритм от Аikar не рекомендовано использовать если для сервера выделено меньше 10Gb оперативной памяти"`
				  	echo `outputGreen "2)"; outputYellow "Простой алгоритм подходить для серверов от 1Gb оперативной памяти"`
				  	if read -p "Алгоритм?: " alg
				  	then
				  		if [ $alg = 1 ];
				  		then
							          if [ $ram -gt 11 ];
									  then	# Больше 11		  
							              echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								          echo "algoritm: java -Xms"$ram"G -Xmx"$ram"G -Xlog:gc*:logs/gc.log:time,uptime:filecount=5,filesize=1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar" >> start_config.yml
							          elif [ $ram -le 11 ];	# Меньше или Равно 11
									  then
							              echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								          echo "algoritm: java -Xms"$ram"G -Xmx"$ram"G -Xlog:gc*:logs/gc.log:time,uptime:filecount=5,filesize=1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar" >> start_config.yml
							          else
									      outputRed "Неверное значения! Ядро будет запущено с $total_ram Gb оперативной памяти"
								          if [ $total_ram -gt 11 ];
									      then	# Больше 11		  
							                  echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								              echo "algoritm: java -Xms"$total_ram"G -Xmx"$total_ram"G -Xlog:gc*:logs/gc.log:time,uptime:filecount=5,filesize=1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar" >> start_config.yml
							              else	# Меньше 11
							                  echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								              echo "algoritm: java -Xms"$total_ram"G -Xmx"$total_ram"G -Xlog:gc*:logs/gc.log:time,uptime:filecount=5,filesize=1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar" >> start_config.yml
							              fi
									  fi
						else
							          if [ $ram -gt 11 ];
									  then	# Больше 11		  
							              echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								          echo "algoritm: java -Xmx"$ram"G -Xmn192M -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -jar" >> start_config.yml
							          elif [ $ram -le 11 ];	# Меньше или Равно 11
									  then
							              echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								          echo "algoritm: java -Xmx"$ram"G -Xmn192M -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -jar" >> start_config.yml
							          else
									      outputRed "Неверное значения! Ядро будет запущено с $total_ram Gb оперативной памяти"
								          if [ $total_ram -gt 11 ];
									      then	# Больше 11		  
							                  echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								              echo "algoritm: java -Xmx"$total_ram"G -Xmn192M -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -jar" >> start_config.yml
							              else	# Меньше 11
							                  echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								              echo "algoritm: java -Xmx"$total_ram"G -Xmn192M -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -jar" >> start_config.yml
							              fi
							          fi
					   fi						  
					fi
                  fi  					  
			  else # java -11			  
			      echo `outputBlue "Количество оперативной память сервера ="; outputYellow "$total_ram"`
				  outputYellow "Введите количество гигабайт которое вы хотите выделить на это ядро(только цыфры)"
			      if read -p "Количество?: " ram
				  then
				  	outputYellow "Выбор алгоритма запуска сервера:"
				  	echo `outputGreen "1)"; outputYellow "Алгоритм от Аikar не рекомендовано использовать если для сервера выделено меньше 10Gb оперативной памяти"`
				  	echo `outputGreen "2)"; outputYellow "Простой алгоритм подходить для серверов от 1Gb оперативной памяти"`
				  	if read -p "Алгоритм?: " alg
				  	then
				  		if [ $alg = 1 ];
				  		then				  	
				                      if [ $ram -gt 11 ];
									  then	# Больше 11		  
							              echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								          echo "algoritm: java -Xms"$ram"G -Xmx"$ram"G -Xloggc:gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar" >> start_config.yml
				                      elif [ $ram -le 11 ];	# Меньше или Равно 11
									  then
							              echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								          echo "algoritm: java -Xms"$ram"G -Xmx"$ram"G -Xloggc:gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar" >> start_config.yml
				                      else
								          outputYellow "Неверное значения! Ядро будет запущено с $total_ram Gb оперативной памяти"
								          if [ $total_ram -gt 11 ];
									      then	# Больше 11		  
							                  echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								              echo "algoritm: java -Xms"$total_ram"G -Xmx"$total_ram"G -Xloggc:gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar" >> start_config.yml
				                          else	# Меньше 11
							                  echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								              echo "algoritm: java -Xms"$total_ram"G -Xmx"$total_ram"G -Xloggc:gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar" >> start_config.yml
				                          fi					  
									  fi
					    else
							          if [ $ram -gt 11 ];
									  then	# Больше 11		  
							              echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								          echo "algoritm: java -Xmx"$ram"G -Xmn192M -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -jar" >> start_config.yml
							          elif [ $ram -le 11 ];	# Меньше или Равно 11
									  then
							              echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								          echo "algoritm: java -Xmx"$ram"G -Xmn192M -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -jar" >> start_config.yml
							          else
									      outputRed "Неверное значения! Ядро будет запущено с $total_ram Gb оперативной памяти"
								          if [ $total_ram -gt 11 ];
									      then	# Больше 11		  
							                  echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								              echo "algoritm: java -Xmx"$total_ram"G -Xmn192M -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -jar" >> start_config.yml
							              else	# Меньше 11
							                  echo '# Алгоритм запуска сервера. Не рекомендуется редактировать этот параметр если вы не знаете что это!' >> start_config.yml
								              echo "algoritm: java -Xmx"$total_ram"G -Xmn192M -Dfile.encoding=UTF-8 -XX:+UseConcMarkSweepGC -jar" >> start_config.yml
							              fi
							          fi
						fi
                    fi
                  fi
              fi				  
}
		  
config_setup(){
			 if [ -f "start_config.yml" ]; 
             then
                outputBlue "Файл конфигурации уже настроен запускаю сервер"	            
             else
                install_wget 
                install_java
                outputBlue "Создания и настройка файла конфигурации"
                core_config
	            autoupdate_core
	            remove_logs
	            algoritm_core
				if [ "$core_vaule" = "62" ] || [ "$core_vaule" = "61" ];
				then
                    echo " "
				else
                    port
					eula
				fi
				echo `outputBlue "Скрипт успешно настроен. Создан файл конфигураций"; outputRed " start_config.yml"`
				outputBlue "Намите Enter что перейти к запуску сервера"
			    if read -p "" go
				then
				    echo $go
				fi
				clear
             fi
}

# Функции Выполнения Конфигураций
autoupdate(){
		    if [ $autoupdate = true ]; 
	        then
	            outputBlue "Обновления ядра..."
	            $core
	        else
	            outputBlue "Автообновления ядра отключено"
	        fi
}

del_logs (){ 
	if [ $del_logs = true ]
	then
	    rm -rf logs/ > /dev/null 2>&1
	    outputBlue "Удаляю папку logs..."
	else
        outputBlue "Удаление папки logs отключено"
	fi
}

start_server(){
                while true
                do
                	if [ -f pl_update.sh ]; then
                      chmod +x ./pl_update.sh
                	  ./pl_update.sh
                	fi
	                autoupdate
	                del_logs
	                outputBlue "Запускаю сервер..."
					echo -e "\033[36m                                 *** Консоль ***\033[0m"
	                $algoritm $jar nogui
                    outputRed "Вероятно, сервер упал, перезапускаю"
                    echo " "
                    echo " "
                    outputBlue "Чтобы отменить нажмите: ctrl + c"
                    echo " "
	                sleep 1
                    echo " "
	                reset_config
                done			 
}

run_screen(){
		    cd $myDir
		    $packets_manager install screen -y > /dev/null 2>&1
			screen -dmS $dir_name
			sleep 1
			pid=`screen -list | grep [0-9] | grep $dir_name`
			screen -p 0 -S $dir_name -X stuff "cd $myDir^m"
            screen -p 0 -S $dir_name -X stuff 'sh start.sh^m'
            echo -e "\033[34mСервер по пути \033[31m$myDir \033[34mзапущено у \033[31mscreen \033[34mпод названием \033[31m$dir_name\033[0m"
            echo " "
            echo -e "\033[34mЧтобы открыть консоль этого сервера: \033[31mscreen -r $dir_name\033[0m"
            echo " "
            echo -e "\033[34mЧтобы убить этот процесс наберите команду \033[33mkill (номер процесса который указан ниже)\033[0m"
            echo -e "\033[31m$pid\033[0m"	
            exit			 
}

run_tmux(){
         if [ -f "$HOME/.tmux.conf.local" ]; then
             echo " "
	     else
		     $packets_manager install tmux -y > /dev/null 2>&1
	         $packets_manager install git -y > /dev/null 2>&1
             git clone https://github.com/GIGABAIT93/.tmux.git $HOME/.tmux/ > /dev/null 2>&1
             ln -s -f $HOME/.tmux/.tmux.conf $HOME/ > /dev/null 2>&1
             cp $HOME/.tmux/.tmux.conf.local . $HOME/ > /dev/null 2>&1
	     fi
		 cd $myDir
         tmux new -s $dir_name -d
         sleep 1
         tmux send-keys -t $dir_name "cd $myDir" Enter
         tmux send-keys -t $dir_name 'sh start.sh' Enter
         echo -e "\033[34mСервер по пути \033[31m$myDir \033[34mзапущено у \033[31mtmux \033[34mпод названием \033[31m$dir_name\033[0m"
         echo " "
         echo -e "\033[34mЧтобы открыть консоль этого сервера: \033[31mtmux attach -t $dir_name\033[0m"
         echo " "
         echo -e "\033[34mЧтобы убить этот процесс наберите команду \033[33mtmux kill-session -t $dir_name\033[0m"			  
         exit		 
}

# Выполнениe Кода
os_check
myDir=$(cd $(dirname $0) && pwd)
cd $myDir
dir_name=`basename $myDir`
jar="server.jar"

if [ $1 = tmux ];
then
    run_tmux
elif [ $1 = screen ];
then
    run_screen
else
    clear
fi

config_setup

core=`grep core: start_config.yml`                                
core=`echo "$core" | tr '.' '_' | cut -c 7- | tr -s " " "_"`;
autoupdate=`grep autoupdate: start_config.yml | cut -c 13-`;      
del_logs=`grep del_logs: start_config.yml | cut -c 11-`;          
algoritm=`grep algoritm: start_config.yml | cut -c 11-`;          


start_server

