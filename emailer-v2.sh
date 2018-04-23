#!/bin/zsh

/sbin/service emailerV2 start
echo -e "\n Iniciando el servicio de Emailer V2"
tail -F -n0 /etc/hosts