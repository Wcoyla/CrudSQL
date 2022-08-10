echo Instalador de la base de datos Universidad
echo Autor Wildor Coyla
sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA.sql
echo Se ejecuto correctamente la base de datos
pause