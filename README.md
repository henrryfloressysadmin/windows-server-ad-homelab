# Windows Server 2022 Active Directory Homelab

Implementación de una infraestructura de dominio empresarial utilizando Windows Server 2022 y un cliente Windows 10.

## Arquitectura y Servicios
* **Controlador de Dominio:** Windows Server 2022 (AD DS + DNS).
* **Cliente:** Windows 10 Pro unido al dominio.
* **Automatización:** Aprovisionamiento masivo de usuarios mediante PowerShell.
* **Seguridad:** Gestión centralizada mediante Políticas de Grupo (GPO).

## Automatización con PowerShell
El script [`crear-usuarios.ps1`](scripts/crear-usuarios.ps1) automatiza la creación de la Unidad Organizativa `Empleados_Empresa` y da de alta 4 cuentas de usuario estándar.

![Estructura AD](img/01-ad-estructura-ou.png)

## Políticas de Grupo (GPO) Implementadas
1. **Restricción de Panel de Control (`GPO-Bloquear-PanelControl`):** Aplicada a nivel de OU para evitar cambios no autorizados por parte de los usuarios.
2. **Endurecimiento de Contraseñas:** Aplicada a nivel de dominio exigiendo complejidad y un mínimo de 10 caracteres.

![Verificación GPO](img/05-cliente-bloqueo.png)

