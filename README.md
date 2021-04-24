# Data Science And Docker MiniProject
Mini proyecto de ciencia de datos utilizando Docker.

# Objetivo
Obtener los casos positivos y negativos de Covid-19 para cada municipio del estado de Sonora a partir de la [base de datos federal de México](https://www.gob.mx/salud/documentos/datos-abiertos-152127) utilizando la línea de comandos de Unix y estableciendo el entorno de trabajo en una imagen de Docker para futuros análisis sobre los datos obtenidos.

# Uso

### Generar imagen de Docker
Para generar la imagen de Docker necesitamos:

1. Instalar Docker
2. Clonar o descargar el repositorio del proyecto
3. Situarnos en la carpeta del repositorio
4. Ejecutar el siguiente comando:

```console
$ docker build -t <nombre_imagen> .
```
Recuerda reemplazar la cadena &lt; nombre_imagen &gt; por el nombre que deseas asignar a la imagen que se va a construir.

### Crear un contenedor a partir de la imagen generada

Para crear un contenedor persistente con la imagen que acabamos de crear ejecutamos la siguiente instrucción:

```console
$ docker run -it --name <nombre_contenedor> <nombre_imagen>
```
### Consultar los resultados
Si enlistamos los archivos contenidos en el directorio de trabajo del contenedor de Docker obtendremos lo siguiente:

```console
(base) root@3328f252cf7f:/data_cleaning# ls
201128_Catalogos.xlsx	 data_processing.yml  numero_positivos_y_negativos_municipios_sonora.csv
210422COVID19MEXICO.csv  fix_data.py	      positivos_y_negativos_municipios_sonora.csv
```

El archivo llamado **positivos_y_negativos_municipios_sonora.csv** es el que almacena el resultado deseado. Podemos echarle un vistazo y confirmar que contiene la sumatoria de los casos positivos y negativos a Covid-19 para cada municipio del estado de Sonora.

```console
(base) root@3328f252cf7f:/data_cleaning# cat positivos_y_negativos_municipios_sonora.csv | head -n 10
TOTAL,MUNICIPIO_RES,CLASIFICACION_FINAL
17,ACONCHI,CASO DE SARS-COV-2  CONFIRMADO
14,ACONCHI,NEGATIVO A SARS-COV-2
1021,AGUA PRIETA,CASO DE SARS-COV-2  CONFIRMADO
851,AGUA PRIETA,NEGATIVO A SARS-COV-2
178,ALAMOS,CASO DE SARS-COV-2  CONFIRMADO
143,ALAMOS,NEGATIVO A SARS-COV-2
76,ALTAR,CASO DE SARS-COV-2  CONFIRMADO
82,ALTAR,NEGATIVO A SARS-COV-2
21,ARIVECHI,CASO DE SARS-COV-2  CONFIRMADO
```
Recuerda reemplazar la cadena &lt; nombre_contenedor &gt; por el nombre que deseas asignar al contenedor que se va a construir.

El nombre de la imagen &lt; nombre_imagen &gt; debe coincidir con el nombre que escribiste al momento de generar la imagen.




Puedes obtener una explicación más detallada en [esta entrada de mi blog](https://pedro-hdez.github.io/docker-y-ciencia-de-datos/).
