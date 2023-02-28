# AnimeList
Fetch list of anime with URLSession - MVVM Architectural Pattern - XIB views

Funcionalidades técnicas de la aplicación:

- Desarrollada en Swift 5.7
- Las vistas están construidas con XIBs
- Se utilizó la arquitectura MVVM extendida
- Comportamiento reactivo con uso de observadores
- No se utilizan librerías de terceros
- Se utiliza una capa genérica y extensible con URLSession para hacer el llamado de los servicios
- Se utiliza Codable para el mapeo de JSON a objetos
- Los enlaces de las capas se implementan con cierres

Arquitectura:

Se implementó MVVM como arquitectura, con las siguientes capas:

Model: Contiene las entidades
View: Contiene las vistas y la lógica de vista
ViewModel: Contiene los casos de uso (acciones de la aplicación y lógica de negocios)
Manager: Se encarga de la obtención de los datos.
Router: Se encarga de la navegación entre controladores.
Factory: Utilizado para la construcción de objetos complejos.

Funcionalidades generales:

La pantalla principal tiene una barra de búsqueda que al recibir datos por parte del usuario filtra el listado de los animes populares, en caso de no encontrar coincidencias mostrará un mensaje de error.
La pantalla principal muestra dos listados de animes obtenidos de la API, los más populares y los mejor calificados.
Cuando se selecciona un anime se direcciona al detalle de este.
La pantalla del detalle nos mostrará el nombre, estado, categoría, imagen de portada y sinopsis del anime.
Hay un activity indicator que se muestra cuando se está realizando una petición al servicio web y se oculta cuando la petición recibe una respuesta.
Hay una alerta que se muestra cuando en el proceso de obtención de datos ocurre un error.
