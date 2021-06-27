#!/bin/bash

#####################################
#                                   #
#  Install GLPI + FusionInventory   #
#         Version : v1.5.2          #
#                                   #
#    by Jérémy TAUNAY / Zatoufly    #
#                                   #
#    Date Création : 23/06/2021     #
#                                   #
#####################################


# Vérification de la connexion internet
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
	echo "Connexion à internet réussi, execution du script ..."


		# Demande de renseignement de la BDD au user
		echo ""
		read -p "Entrer le nom de la Database : " BDDNAME
		if [ "$BDDNAME" != "glpi" ] && [ "$BDDNAME" != "GLPI" ]; then
			echo "Le nom préconisé pour la base de données est glpi ou GLPI"
			read -p "Etes-vous certain de garder ce nom ? [y/n] " REPONSE
				if [ $REPONSE = "n" ]; then
					read -p "Entrer votre nouveau nom pour la base : " BDDNAME
				else
					echo "Le nom de la database a été enregistré, continuons..."
				fi
		else
			echo "Le nom de la database a été enregistré, continuons..."
		fi

	echo ""
	echo "Créer l'utilisateur de la Database"
	read -p "User : " BDDUSER

	echo ""
	echo "Créer le MDP de la Database"
	read -sp "MDP Database : " BDDPASSWORD
	echo ""


	# Mise à jour du système
	apt update 


	# Installation server LAMP
	apt install apache2 php mariadb-server -y
	systemctl enable apache2.service
	systemctl enable mariadb.service
	rm /var/www/html/index.html


	# Installation de GLPI
	apt install perl unzip php-ldap php-imap php-apcu php-xmlrpc php-cas php-mysqli php-mbstring php-curl php-gd php-simplexml php-xml php-intl php-zip php-bz2 -y
	systemctl reload apache2
	cd /tmp/
	wget github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz --no-check-certificate
	tar xzf glpi-9.5.5.tgz
	cp -R /tmp/glpi /var/www/html
	chown -R root.www-data /var/www/html/glpi
	chmod -R 775 /var/www/html/glpi
	rm -fr glpi glpi-9.5.5.tgz


	# Installation de Fusioninventory
	read -p "Voulez vous installer le plugin FusionInventory ? [y/n] : " FUSION
	if ["$FUSION" = "y"]; then
		cd /var/www/html/glpi/plugins
		wget https://github.com/fusioninventory/fusioninventory-for-glpi/archive/refs/heads/glpi9.5.zip --no-check-certificate
		unzip glpi9.5.zip
		chown -R www-data /var/www/html/glpi/plugins
		mv fusioninventory-for-glpi-glpi9.5/ fusioninventory/
		systemctl reload apache2
	else
		echo "Fusion Inventory ne sera pas installé"
	fi


	# Création de la database
	mysql -e "CREATE DATABASE ${BDDNAME};"
	mysql -e "CREATE USER ${BDDUSER}@localhost IDENTIFIED BY '${BDDPASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON ${BDDNAME}.* TO '${BDDUSER}'@'localhost';"
	mysql -e "FLUSH PRIVILEGES;"


	# Information
	IP=$(hostname -I)
	URL="https://$IP/glpi"
	URL=$(echo $URL | tr -d ' ')
	echo ""
	echo "Tappez cette url dans votre navigateur : $URL"
	echo ""

else
	echo "Vérifiez votre connexion internet"
fi