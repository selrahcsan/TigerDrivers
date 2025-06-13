# Gerenciador de Drivers NVIDIA para TigerOS

Este script ajuda a gerenciar os drivers NVIDIA no sistema TigerOS (baseado no Ubuntu), facilitando a instalação dos drivers recomendados ou outros drivers disponíveis, diretamente da interface gráfica com o auxílio do `yad`.

## Funcionalidades

- Verifica se o `yad` está instalado e notifica o usuário caso não esteja.
- Verifica a presença de dispositivos compatíveis com drivers NVIDIA.
- Exibe uma lista dos drivers NVIDIA disponíveis, incluindo o recomendado.
- Permite a instalação do driver escolhido de forma fácil e segura, utilizando `pkexec` para elevação de privilégios.
- Confirmação antes de proceder com a instalação.

## Requisitos

- **yad**: Utilizado para criar a interface gráfica. Caso não esteja instalado, o script orienta o usuário a instalá-lo.
- **ubuntu-drivers**: Ferramenta para detectar automaticamente o driver recomendado para a placa gráfica NVIDIA.
- **apt**: Utilizado para instalar os drivers.

### Instalando o YAD

Caso o `yad` não esteja instalado em seu sistema, você pode instalá-lo com o seguinte comando:

```bash
sudo apt install yad
