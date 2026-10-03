<div align="center">

# 🛒 BuscaRapi

### Descubre y promociona productos y servicios de negocios locales en Bolivia

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Laravel](https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)](https://laravel.com)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

🏆 **Primer lugar — Feria Institucional de Innovación del Instituto Tecnológico del Occidente**

</div>

---

## 📖 Descripción

**BuscaRapi** es una aplicación móvil desarrollada en Flutter que permite descubrir y promocionar productos y servicios de negocios locales en Bolivia. Los usuarios pueden encontrar comercios cercanos, explorar sus catálogos y contactarlos a través de diferentes mecanismos como NFC, códigos QR y geolocalización.

El proyecto combina una aplicación móvil multiplataforma con un backend robusto en Laravel que expone una API RESTful consumida por la app.

---

## ✨ Características principales

- 🔍 **Búsqueda inteligente** de negocios por categoría, ubicación y recomendaciones personalizadas.
- 📍 **Geolocalización y mapas** para encontrar comercios cercanos.
- 📱 **Integración NFC** para acceder rápidamente a la información del negocio.
- 🔳 **Lectura de códigos QR** para promociones y fichas de producto.
- ☁️ **Almacenamiento en la nube** con Cloudinary para imágenes y recursos.
- 🔐 **Autenticación de usuarios** y gestión de perfiles.
- 🌐 **API RESTful** en Laravel para comunicación con la app.

---

## 🛠️ Stack tecnológico

| Capa | Tecnologías |
|------|-------------|
| **Frontend móvil** | Flutter · Dart |
| **Backend** | Laravel · PHP · API RESTful |
| **Base de datos** | MySQL |
| **Almacenamiento** | Cloudinary |
| **Integraciones** | NFC · Códigos QR · Google Maps · Geolocalización |

---

## 🏗️ Arquitectura
┌─────────────────────┐ ┌──────────────────────┐
│ App Flutter │ ◄─────► │ API REST Laravel │
│ (Android / iOS) │ HTTP │ (PHP + MySQL) │
└─────────────────────┘ └──────────────────────┘
│ │
│ │
▼ ▼
NFC / QR / GPS Cloudinary (imágenes)

---

## 🚀 Instalación

### Requisitos previos

- Flutter SDK `>=3.0.0`
- PHP `>=8.1`
- Composer
- MySQL `>=8.0`

### Backend (Laravel)

```bash
# Clonar el repositorio
git clone https://github.com/J0hannLara/buscarapi-web-admin.git
cd buscarapi-backend

# Instalar dependencias
composer install

# Configurar variables de entorno
cp .env.example .env
php artisan key:generate

# Configurar la base de datos en .env
# DB_DATABASE=buscarapi
# DB_USERNAME=root
# DB_PASSWORD=

# Ejecutar migraciones
php artisan migrate --seed

# Iniciar servidor
php artisan serve
App móvil (Flutter)
bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/buscarapi-app.git
cd buscarapi-app

# Instalar dependencias
flutter pub get

# Configurar la URL de la API en lib/config/api_config.dart

# Ejecutar la app
flutter run
```

🎯 Roadmap
☑ Autenticación de usuarios
☑ Búsqueda por categorías
☑ Geolocalización y mapas
☑ Integración NFC y QR
☑ Almacenamiento en Cloudinary
□ Recomendaciones con machine learning
□ Panel administrativo para comercios
□ Notificaciones push
👨‍💻 Autor
Laradev — Desarrollador Full Stack

https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white
https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white

<div align="center">
⭐ Si te gustó este proyecto, dale una estrella ⭐

</div> ```