# Centro Medico
Prueba técnica SIFCO

- IDE utilizado: Visual Studio 2022
- Framework de la aplicación web: Aplicación Web de ASP.NET Core, con Razor Pages y Entity Framework, .NET 8
- Framework de la API: AP.NET Core Web API, .NET 8
- Base de datos: SQL Server, 2021

1. Crear una DB llamada CentroMedicoDB y correr ``` Parte 1 - Script Tablas.sql ```
2. Abrir: ```CentroMedico.sln```
Dentro de la solución estan alojados el cliente web y la API.

3. Configurar la cadena de conexión en ``` appsettings.json ```
4. Ejecutar CentroMedico o APICentroMedico
5. URL para la consulta de la API desde Postman por ejemplo:
-	Obtener todos en orden ascendente GET http://localhost:5031/api/Pacientes/listado?orden=A
-	Obtener por DPI GET http://localhost:5031/api/Pacientes/dpi/<DPI>
-	Insertar POST http://localhost:5031/api/pacientes/
			Ejemplo de objeto:
```
{
  "nombreCompleto": "Luis Varela",
  "fechaNacimiento": "2025-06-10T06:24:22.062Z",
  "sexo": "M",
  "dpi": "1234567891023"
}
```
6. Para las estadisticas SQL ejecutar ```Parte 3 - Scripts Estadisticas.sql```
Si se desean datos de prueba ejecutar: ```Inserts de ejemplo.sql```
