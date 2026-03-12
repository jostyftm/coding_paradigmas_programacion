FROM ubuntu:20.04

# Evitar prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    wget \
    tcl \
    tk \
    emacs \
    && rm -rf /var/lib/apt/lists/*

# Descargar e instalar Mozart 2
RUN wget https://github.com/mozart/mozart2/releases/download/v2.0.1/mozart2-2.0.1-x86_64-linux.deb \
    && dpkg -i mozart2-2.0.1-x86_64-linux.deb || apt-get install -f -y \
    && rm mozart2-2.0.1-x86_64-linux.deb

# Configurar el directorio de trabajo
WORKDIR /app

# Mantener el contenedor en ejecución (idle) para poder enviarle comandos
CMD ["tail", "-f", "/dev/null"]