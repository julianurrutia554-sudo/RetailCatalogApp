Template iOS App using Clean Architecture and MVVM

El proyecto está dividido en capas concéntricas aisladas siguiendo las reglas de dependencia de **Clean Architecture**:

<img width="507" height="211" alt="image" src="https://github.com/user-attachments/assets/489b8300-5723-4d4a-8777-2b57b3637902" />

📂 RetailCatalog (Template Root)
│
├── 📂 Application
│   ├── 📂 DI                        # Inyección centralizada de dependencias (Factory)
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift          # Inicialización 100% programática de la UI
│
├── 📂 Presentation                  # CAPA DE PRESENTACIÓN (MVVM-C)
│   ├── 📂 FlowCoordinators          # Patrón Coordinator para control de navegación
│   └── 📂 ProductList               # Módulo específico (escalable por flujo)
│       ├── 📂 Views                 # UI en Código (UIKit puro / UIView / Cells)
│       ├── 📂 ViewModels            # Lógica de la vista y Máquina de Estados
│       └── 📂 ModelUI               # Modelos visuales formateados para la UI
│
├── 📂 Domain                        # CAPA DE DOMINIO (Reglas de Negocio Puras)
│   ├── 📂 Entities                  # Modelos de negocio puros (Structs nativos)
│   ├── 📂 UseCases                  # Casos de Uso (Lógica de aplicación)
│   └── 📂 Interfaces                # Protocolos de los Repositorios
│
├── 📂 Data                          # CAPA DE DATOS (Implementación)
│   ├── 📂 Repositories              # Implementación concreta de los Repositorios
│   ├── 📂 Network                   # Data Transfer Objects (DTOs) y Mappers
│   └── 📂 DataMapping               # Codable mappings específicos de la API
│
└── 📂 Infrastructure                # CAPA DE INFRAESTRUCTURA (Detalle Técnico)
    ├── 📂 Network                   # APIClient, DataTransferService, Endpoint, configuration
    └── 📂 KeyValueStorage           # UserDefaults / Cache persistence




