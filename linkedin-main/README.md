# LinkedIn Laboral - API PHP

Este proyecto es una API en PHP para gestionar llamados laborales, empresas, usuarios y postulaciones, similar a LinkedIn.

## Estructura
- **routes/**: Endpoints para el frontend.
- **controller/**: Lógica de negocio y respuestas en JSON.
- **modelo/**: Acceso a la base de datos y sentencias SQL.
- **database.sql**: Script para crear y poblar la base de datos.

## Seguridad de contraseñas
Las contraseñas de los usuarios se almacenan usando el hash bcrypt generado por la función `password_hash()` de PHP. Este hash comienza con `$2y$` y es el recomendado para aplicaciones PHP.

### Ejemplo de hash
```php
$hash = password_hash('1234', PASSWORD_DEFAULT);
// Resultado: $2y$10$...
```

### Verificación en login
Para verificar la contraseña en el login, se utiliza la función `password_verify()`:

```php
if (password_verify($passwordIngresada, $hashAlmacenado)) {
    // Contraseña correcta
} else {
    // Contraseña incorrecta
}
```

## Instalación
1. Importa el archivo `database.sql` en tu servidor MySQL.
2. Configura los datos de conexión en `modelo/Conexion.php`.
3. Accede a los endpoints desde la carpeta `routes/`.

## Endpoints principales
- `routes/llamados.php`: Devuelve los llamados laborales en formato JSON.

---

Para dudas o mejoras, contacta al autor del repositorio.
