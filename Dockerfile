# Usa una imagen base de Nginx
FROM nginx:latest

# Copia el archivo holaMundo.html al directorio de contenido de Nginx
COPY holaMundo.html /usr/share/nginx/html/index.html

# Copia el contenido de la carpeta js (si es necesario)
COPY js /usr/share/nginx/html/js

# Exponer el puerto 80 para el contenedor
EXPOSE 80

