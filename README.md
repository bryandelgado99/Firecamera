# 🖼️🔥 Firecamera

Una aplicación de fotografía y previsualización de imágenes, desarrollada con Flutter y Firebase.

![Logo](https://th.bing.com/th/id/R.d4b76713e39bef3ff17cdce0a955b98d?rik=wtpMb6BzysL4jg&riu=http%3a%2f%2frumbum.co%2fwp-content%2fuploads%2f2020%2f11%2f3da097bfde49aef8e7b0aa00b7ac3ae1.png&ehk=ch65lIthB5z6uHK%2b%2fzw3Jed8qkH%2fOdI4%2bp0ocijCVrg%3d&risl=&pid=ImgRaw&r=0)

## 📒 Funciones

- Envia fotos de manera local o tomadas con la cámara de tus dispositivo
- Visualiza las fotografías que se hayan subido al Storage de Firebase.

## 💻 Tecnologías

**😀 Cliente:**
Flutter - Android - Webkits - Firebase

[![Tecnologías](https://simpleskill.icons.workers.dev/svg?i=flutter,html5,android,firebase)](https://skillicons.dev)

**🖥️ Servidor:**
Servicios de Firebase: Storage y Hosting

[![Tecnologías](https://simpleskill.icons.workers.dev/svg?i=firebase,google)](https://skillicons.dev)

## ⏬ Instalacion

Clona el proyecto

```bash
  git clone https://github.com/bryandelgado99/Firecamera.git
```
o, si usas GitHub CLI:

```bash
  gh repo clone bryandelgado99/Firecamera
```

Ve a la carpeta del proyecto

```bash
  cd Firecamera
```

Instala las dependencias necesarias para el proyecto de Flutter

```bash
  flutter pub get
```

## 🛑 ADVERTENCIA

Revisa que tengas instalado Firebase en tu equipos, sino, usa el comando:

```bash
  npm install -g firebase-tools
```

Inicializa la aplicación con los siguientes comandos:

```bash
  flutter run --web / flutter run
```

>[!IMPORTANT]
>Recuerda que para probar la apliación en un dispositivo Android, debes conectar tu equipo en modo de *Depuración USB* o *Depuración Inalámbrica*.
>También puedes crear un dispositivo virtual, en base los componentes y recursos de tu equipo.

## 🍃 Variables de Entorno

Para ejecutar este proyecto necesitaras dirijirte a archivo .env y colocar tus variables de entorno de la siguiente manera:

```Firebase Options
    apiKey: 'API_KEY',
    appId: 'APP_ID',
    messagingSenderId: 'MESSAGE_SENDER',
    projectId: 'PROJECT_ID',
    storageBucket: 'STORAGE_URL',
```
## 🧩 Uso/Ejemplos

### 😀 inicio de la aplicación  
![App Screenshot](https://github.com/bryandelgado99/Firecamera/blob/43d7d5d6b70d71b53b5cc4b16abb2be35be44160/resources/Imagen%20de%20WhatsApp%202024-07-19%20a%20las%2001.49.05_68fd1fb0.jpg)

### ✍️ Menú de navegación  
![App Screenshot](https://github.com/bryandelgado99/Firecamera/blob/ea20945aa8977be2c33102e80386b95b394c73e1/resources/Imagen%20de%20WhatsApp%202024-07-19%20a%20las%2001.49.04_d75afb62.jpg)

### 📲 Subida de imágenes  
![App Screenshot](https://github.com/bryandelgado99/Firecamera/blob/ea20945aa8977be2c33102e80386b95b394c73e1/resources/Imagen%20de%20WhatsApp%202024-07-19%20a%20las%2002.00.51_effc069e.jpg)
![App Shot](https://github.com/bryandelgado99/Firecamera/blob/ea20945aa8977be2c33102e80386b95b394c73e1/resources/Imagen%20de%20WhatsApp%202024-07-19%20a%20las%2002.00.59_dd3963e3.jpg)

### 📲 Pasarela de imágenes  
![App Screenshot](https://github.com/bryandelgado99/Firecamera/blob/ea20945aa8977be2c33102e80386b95b394c73e1/resources/Imagen%20de%20WhatsApp%202024-07-19%20a%20las%2001.49.04_af213871.jpg)

### 📲 Demostración Web  
![App Screenshot](resources/web_init.png)

### 📲 Información de la aplicación  
![App Screenshot](resources/web_info.png)

## 🌎 Demo

Si quieres probar la aplicación puedes hacerlo desde el siguiente enlace:

[Despliegue Web con Flutter](https://firecamera-fa8e5.web.app/)

O si quieres probar el proyecto en Moviles puedes hacerlo desde aqui para descargar la APK

[Descarga el APK](https://github.com/bryandelgado99/Firecamera/releases/tag/1.0.0)
