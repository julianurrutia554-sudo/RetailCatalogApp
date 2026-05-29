Plantilla de aplicación iOS que utiliza arquitectura limpia y MVVM.

El proyecto está dividido en capas concéntricas aisladas siguiendo las reglas de dependencia de **Clean Architecture**:

<img width="507" height="211" alt="image" src="https://github.com/user-attachments/assets/489b8300-5723-4d4a-8777-2b57b3637902" />

<img width="923" height="562" alt="image" src="https://github.com/user-attachments/assets/96976328-b46c-4e98-b32f-2f269a547d88" />

Responsabilidades por Capa:
Domain: Contiene la lógica de negocio pura e independiente del framework. Los casos de uso aplican las reglas de negocio (como el ordenamiento alfabético automático de productos) sin saber de dónde vienen los datos.

Data & Infrastructure: Implementa el acceso a datos. Esconde la complejidad técnica del consumo de APIs REST, descifrado de JSONs o persistencia local tras el Patrón Repositorio.

Presentation (MVVM-C): Implementa Data-Driven UI mediante máquinas de estado (.idle, .loading, .success, .error). El Coordinator asume la responsabilidad exclusiva de la navegación, liberando a los ViewControllers.

Patrones de Diseño Utilizados
Inversión de Dependencias (DI): Implementado de manera estática y segura en tiempo de compilación utilizando Factory. Permite desacoplamiento total y sustitución inmediata por Mocks en entornos de prueba.

Patrón Repositorio: Actúa como una fachada única de datos para el dominio, abstrayendo si el recurso se obtiene de la red (URLSession) o de la caché local (CoreData).

Data Transfer Object (DTO) + Mappers: Mantiene los modelos de red separados de las entidades del negocio, blindando la app ante cambios imprevistos en los contratos del Backend.

MainActor Isolation (Swift 6 Concurrency): Seguridad de hilos garantizada por el compilador. Toda la capa de presentación y UI corre estrictamente en el hilo principal para evitar condiciones de carrera (race conditions).





