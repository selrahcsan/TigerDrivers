#!/bin/bash


if ! command -v yad &> /dev/null; then
    zenity --error --text="O 'yad' não está instalado. Instale com: sudo apt install yad"
    exit 1
fi


DRIVERS_INFO=$(ubuntu-drivers devices 2>/dev/null)

if [ -z "$DRIVERS_INFO" ]; then
    yad --error --text="Nenhum dispositivo compatível com drivers NVIDIA foi detectado."
    exit 1
fi


RECOMENDADO=$(echo "$DRIVERS_INFO" | grep recommended | awk '{print $3}')

# Lista drivers NVIDIA disponíveis
DISPONIVEIS=$(apt-cache search nvidia-driver | grep -E "^nvidia-driver-[0-9]+" | awk '{print $1}' | sort -Vr)

# Mostra uma caixa de seleção com os drivers disponíveis
SELECIONADO=$(yad --list --title="Gerenciador de Drivers Nvidia para o TigerOS " \
    --text="Drivers NVIDIA disponíveis. O recomendado é: $RECOMENDADO" \
    --column="Driver NVIDIA" $DISPONIVEIS --width=400 --height=300 --center \
    --button="Instalar Driver":0 --button="Cancelar":1)

# Captura saída
RETORNO=$?

# Se usuário escolheu instalar
if [ "$RETORNO" -eq 0 ]; then
    DRIVER_ESCOLHIDO=$(echo "$SELECIONADO" | cut -d '|' -f 1)

    if [ -n "$DRIVER_ESCOLHIDO" ]; then
        # Confirmação
        yad --question --title="Confirmação" \
            --text="Tem certeza que deseja instalar o driver: $DRIVER_ESCOLHIDO?"

        if [ $? -eq 0 ]; then
            # Rodar instalação com pkexec para elevar privilégio
            pkexec bash -c "apt update && apt install -y $DRIVER_ESCOLHIDO" && \
            yad --info --text="Driver $DRIVER_ESCOLHIDO instalado com sucesso!"
        else
            yad --info --text="Instalação cancelada pelo usuário."
        fi
    fi
fi
 -------
