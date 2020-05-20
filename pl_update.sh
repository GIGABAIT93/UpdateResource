#!/usr/bin/env bash
outputBlue(){
    echo -e '\e[34m'$1'\e[0m';  # синий
}

myDir=$(cd $(dirname $0) && pwd)
cd $myDir
dir_name=`basename $myDir` 
PLUGINS=`wget -q -O- https://github.com/GIGABAIT93/UpdateResource/raw/master/plugin.yml | grep "plugins:" | cut -c 10-`

# Проверка наличия необходимых каталогов и файлов
if ! [ -d .pl_version ]; then
    for pl in $PLUGINS; do
	    wget -P $myDir/.pl_version/$pl https://github.com/GIGABAIT93/UpdateResource/raw/master/"$pl"/version.yml > /dev/null 2>&1
	    ID=`cat $myDir/.pl_version/$pl/version.yml | grep "id:" | cut -c 1-`
	    sed -i s/"$ID"/"id: 0"/g  $myDir/.pl_version/$pl/version.yml > /dev/null 2>&1
	    if ! [ -f start_config.yml ]; then
	    	echo ' ' >> start_config.yml
	    	echo '# Чтоб отключить сохранение бекап плагинов замените "true" на "false"' >> start_config.yml
	    	echo "old_plugins: true" >> start_config.yml
	    	echo '# Чтоб включить автообновления нужного плагина замените "false" на "true"' >> start_config.yml
	    	echo ""$pl": false" >> start_config.yml
	    	outputBlue "Добавленa возможность обновления плагина: $pl"
	    else
	    	if grep "old_plugins" start_config.yml > /dev/null 2>&1
	    	then
	    		outputBlue "" > /dev/null 2>&1
	    	else
	    		echo ' ' >> start_config.yml
	    		echo '# Чтоб отключить сохранение бекап плагинов замените "true" на "false"' >> start_config.yml
	    		echo "old_plugins: true" >> start_config.yml
	    		echo '# Чтоб включить автообновления нужного плагина замените "false" на "true"' >> start_config.yml
	    	fi
	    	if grep "$pl" start_config.yml > /dev/null 2>&1 
	    	then
	    		outputBlue "" > /dev/null 2>&1
	    	else
	    		echo ""$pl": false" >> start_config.yml
	    		outputBlue "Добавленa возможность обновления плагина: $pl"
	    	fi
	    fi
    done
else
    for pl in $PLUGINS; do
    	if ! [ -d .pl_version/"$pl" ]; then
    		wget -P $myDir/.pl_version/$pl https://github.com/GIGABAIT93/UpdateResource/raw/master/"$pl"/version.yml > /dev/null 2>&1 
	        ID=`cat $myDir/.pl_version/$pl/version.yml | grep "id:" | cut -c 1-`
	        sed -i s/"$ID"/"id: 0"/g  $myDir/.pl_version/$pl/version.yml > /dev/null 2>&1
    	fi
	    if ! [ -f start_config.yml ]; then
	    	echo ' ' >> start_config.yml
	    	echo '# Чтоб отключить сохранение бекап плагинов замените "true" на "false"' >> start_config.yml
	    	echo "old_plugins: true" >> start_config.yml
	    	echo '# Чтоб включить автообновления нужного плагина замените "false" на "true"' >> start_config.yml
	    	echo ""$pl": false" >> start_config.yml
	    	outputBlue "Добавленa возможность обновления плагина: $pl"
	    else 
	    	if grep "old_plugins" start_config.yml > /dev/null 2>&1
	    	then
	    		outputBlue "" > /dev/null 2>&1
	    	else
	    		echo ' ' >> start_config.yml
	    		echo '# Чтоб отключить сохранение бекап плагинов замените "true" на "false"' >> start_config.yml
	    		echo "old_plugins: true" >> start_config.yml
	    		echo '# Чтоб включить автообновления нужного плагина замените "false" на "true"' >> start_config.yml
	    	fi
	    	if grep "$pl" start_config.yml > /dev/null 2>&1
	    	then 
	    		outputBlue "" > /dev/null 2>&1
	    	else
	    		echo ""$pl": false" >> start_config.yml
	    		outputBlue "Добавленa возможность обновления плагина: $pl"
	    	fi
	    fi
    done
fi

# Обновление плагинов
for pl in $PLUGINS; do
	pl_vaule=`grep "$pl" start_config.yml` > /dev/null 2>&1
	if [ "$pl_vaule" = ""$pl": true" ]; then
		id_git=`wget -q -O- https://github.com/GIGABAIT93/UpdateResource/raw/master/"$pl"/version.yml | grep "id:" | cut -c 5-` > /dev/null 2>&1
		id=`cat $myDir/.pl_version/"$pl"/version.yml | grep "id:" | cut -c 5-` > /dev/null 2>&1
		if [[ "$id_git" > "$id" ]]; then
			old_pl=`cat $myDir/start_config.yml | grep "old_plugins:" | cut -c 14-`
			if [ "$old_pl" = "true" ]; then
				d=`date +"%m-%d-%Y"`
				t=`date +"%T"`
				mkdir -p $myDir/OldPlugins/$pl > /dev/null 2>&1
				outputBlue "Обнаружена новая версия плагина $pl"
				outputBlue "Обновление..."
				mv $myDir/plugins/"$pl".jar $myDir/OldPlugins/"$pl"/"$pl"_t="$t"_d="$d".jar > /dev/null 2>&1
				wget -P $myDir/plugins https://github.com/GIGABAIT93/UpdateResource/raw/master/"$pl"/"$pl".jar > /dev/null 2>&1
				sed -i s/"$id"/"$id_git"/g  $myDir/.pl_version/$pl/version.yml > /dev/null 2>&1
			else
				outputBlue "Обнаружена новая версия плагина $pl"
				outputBlue "Обновление..."
				rm $myDir/plugins/"$pl".jar > /dev/null 2>&1
				wget -P $myDir/plugins https://github.com/GIGABAIT93/UpdateResource/raw/master/"$pl"/"$pl".jar > /dev/null 2>&1
				sed -i s/"$id"/"$id_git"/g  $myDir/.pl_version/$pl/version.yml > /dev/null 2>&1
			fi
		fi		
	fi
done