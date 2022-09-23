#!/bin/bash

#####################################
#                                   #
#  Prépa d'un serveur pour homelab  #
#         Version : v0.1.0          #
#                                   #
#    by Jérémy TAUNAY / Zatoufly    #
#                                   #
#    Creation Date : 23/09/2022     #
#                                   #
#####################################


# Vérification de la connexion internet
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        echo "Connexion à internet réussi, execution du script ..."

        echo ""
        echo "Modifier le nom du système."
        read -p "Nom du système : " SYSTEMNAME

        # Mise à jour du système
        apt update && apt upgrade -y
        echo "MAJ OK"

        # Création de la database
        hostnamectl set-hostname ${SYSTEMNAME}

        # Installation des logiciels
        apt install vim -y

else
        echo "Vérifiez votre connexion internet"
fi