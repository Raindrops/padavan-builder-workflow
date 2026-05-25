#!/bin/bash
echo "=== Начинаем исправление ошибки BusyBox ==="

# Ищем конфигурационный файл BusyBox и отключаем компиляцию CAN-модуля
find padavan-ng/ -name "config_base" -exec sed -i 's/CONFIG_FEATURE_IP_LINK_CAN=y/CONFIG_FEATURE_IP_LINK_CAN=n/g' {} +

# На всякий случай также добавляем макросы в сам iplink.c (двойная страховка)
find padavan-ng/ -name "iplink.c" -exec sed -i '/#include <linux\/version.h>/a \
#ifndef CAN_CTRLMODE_FD\n#define CAN_CTRLMODE_FD 0x02\n#define CAN_CTRLMODE_FD_NON_ISO 0x04\n#define CAN_CTRLMODE_PRESUME_ACK 0x08\n#define IFLA_CAN_TERMINATION 11\n#endif' {} +

echo "=== Исправление успешно применено! ==="
