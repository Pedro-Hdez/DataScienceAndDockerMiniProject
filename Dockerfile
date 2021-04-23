# Tomamos como base la imagen de ubuntu
FROM ubuntu

FROM continuumio/miniconda3

LABEL Pedro Hernandez <pedro.a.hdez.a@gmail.com>

# Creamos un directorio y lo asignamos como workdir
RUN mkdir data_cleaning

WORKDIR /data_cleaning

# Actualizamos todos los paquetes e instalamos los que faltan
RUN apt -y update
RUN apt install -y curl unzip csvkit 

# Descargamos los datos
RUN curl -O http://datosabiertos.salud.gob.mx/gobmx/salud/datos_abiertos/datos_abiertos_covid19.zip

# Descomprimimos el archivo y eliminamos el zip
RUN unzip datos_abiertos_covid19.zip && rm datos_abiertos_covid19.zip

# Obtenemos la suma de los negativos y confirmados de covid para cada municipio de Sonora y 
# guardamos el resultado en el archivo "numero_positivos_y_negativos_municipios_sonora.csv"
RUN csvcut -c ENTIDAD_RES,MUNICIPIO_RES,CLASIFICACION_FINAL 210422COVID19MEXICO.csv | \
    csvgrep -c ENTIDAD_RES -m "26" | csvcut -c MUNICIPIO_RES,CLASIFICACION_FINAL | \
    csvgrep -c CLASIFICACION_FINAL -r "[37]" | csvsort --no-inference -c 1,2 | uniq -c | \
    tail -n+2 | sed -e 's/\s\+/,/g' | cut -c 2- > numero_positivos_y_negativos_municipios_sonora.csv

RUN sed -i '1s/^/TOTAL,MUNICIPIO_RES,CLASIFICACION_FINAL\n/' numero_positivos_y_negativos_municipios_sonora.csv

CMD ["bash"]

# El archivo anterior tendrá como valores en sus renglones el total, las claves de los municipios
# y la clave de la clasificación. Para mapear estas claves a sus respectivos valores haremos
# uso de un script de python.

# Copiamos el entorno de anaconda, el catálogo de los datos y el script para arreglar los datos
COPY data_processing.yml .
COPY 201128_Catalogos.xlsx .
COPY fix_data.py .

# Creamos el entorno de anaconda y configuramos bash para correr anaconda
RUN conda env create -f data_processing.yml
SHELL ["conda", "run", "-n", "data_processing", "/bin/bash", "-c"]
SHELL ["conda", "run", "--no-capture-output", "-n", "data_processing", "python", "fix_data.py"]

# Corremos el script para arreglar los datos
RUN python fix_data.py