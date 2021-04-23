import pandas as pd

# Leyendo la hoja de municipios de los catálogos
df_municipios = pd.read_excel(io="201128_Catalogos.xlsx", 
                          sheet_name="Catálogo MUNICIPIOS")

# Leyendo la hoja de clasificación final de los catálogos
df_clasificacion = pd.read_excel(io="201128_Catalogos.xlsx", 
                          sheet_name="Catálogo CLASIFICACION_FINAL", skiprows=2)

# Leyendo el csv que nosotros obtuvimos
df_datos = pd.read_csv("numero_positivos_y_negativos_municipios_sonora.csv", index_col=None)                   

# Obtenemos los municipios de sonora (con CLAVE_ENTIDAD == 26) y eliminamos dicha columna
df_municipios = df_municipios.loc[df_municipios['CLAVE_ENTIDAD'] == 26].drop(['CLAVE_ENTIDAD'], axis=1)

# Reemplazamos los datos en nuestro csv de acuerdo al nombre del municipio asignado a cada clave.
# Esta información la obtenemos del catálogo de municipios 
df_datos['MUNICIPIO_RES'] = df_datos['MUNICIPIO_RES'].map(df_municipios.set_index('CLAVE_MUNICIPIO')['MUNICIPIO'])

# Reemplazamos la clasificación final en nuestros datos de acuerdo a la clave asignada. Esta
# información la obtenemos del catálogo de clasificaciones finales
df_datos['CLASIFICACION_FINAL'] = df_datos['CLASIFICACION_FINAL'].map(df_clasificacion.set_index('CLAVE')['CLASIFICACIÓN'])

# Guardamos la información en un csv
df_datos.to_csv("positivos_y_negativos_municipios_sonora.csv", index=False)