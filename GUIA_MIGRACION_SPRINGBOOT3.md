# Guía de Migración a Spring Boot 3.3

## Resumen de cambios

| Antes | Después |
|-------|---------|
| Spring MVC 4.2.6 | Spring Boot 3.3.1 |
| Java 8 | Java 17 |
| Tomcat 8 | Tomcat 10 |
| javax.* | jakarta.* |
| WebSecurityConfigurerAdapter | SecurityFilterChain |
| WebMvcConfigurerAdapter | WebMvcConfigurer |

---

## Paso 1: Preparar el proyecto

### 1.1 Hacer backup
```powershell
# Copiar el proyecto actual
Copy-Item -Path "c:\Users\mi17040\Documents\fifa\fifaXGamesrs" -Destination "c:\Users\mi17040\Documents\fifa\fifaXGamesrs_backup" -Recurse
```

### 1.2 Reemplazar pom.xml
```powershell
# Renombrar archivos
Rename-Item "pom.xml" "pom-old.xml"
Rename-Item "pom-springboot3.xml" "pom.xml"
```

### 1.3 Reemplazar application.properties
```powershell
cd src\main\resources
Rename-Item "application.properties" "application-old.properties"
Rename-Item "application-springboot3.properties" "application.properties"
```

---

## Paso 2: Migrar imports javax → jakarta

### 2.1 Lista de cambios necesarios

Buscar y reemplazar en TODOS los archivos Java:

| Buscar | Reemplazar por |
|--------|----------------|
| `import javax.servlet.` | `import jakarta.servlet.` |
| `import javax.sql.` | `import jakarta.sql.` | 
| `import javax.annotation.` | `import jakarta.annotation.` |

### 2.2 Archivos que necesitan cambio

```
src/main/java/com/spring/AppInitializer.java
src/main/java/com/app/controller/UserManagerController.java
src/main/java/com/app/controller/TestController.java
src/main/java/com/app/utils/ApplicationConfig.java
```

### 2.3 Ejemplo de cambio

**Antes:**
```java
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.sql.DataSource;
```

**Después:**
```java
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.sql.DataSource;  // Este puede quedarse como javax si es solo SQL
```

---

## Paso 3: Eliminar clases de configuración antiguas

### 3.1 Eliminar o renombrar estas clases (ya no son necesarias):

```
src/main/java/com/spring/AppInitializer.java          → ELIMINAR
src/main/java/com/spring/ConfiguracionMVC.java        → ELIMINAR  
src/main/java/com/spring/ConfiguracionSpringSecurity.java → ELIMINAR
```

Las nuevas clases ya están creadas en:
```
src/main/java/com/fifaxgamers/FifaXGamersApplication.java  ← Nueva clase principal
src/main/java/com/fifaxgamers/config/SecurityConfig.java   ← Nueva seguridad
src/main/java/com/fifaxgamers/config/WebConfig.java        ← Nueva config MVC
```

---

## Paso 4: Actualizar Controllers

### 4.1 Cambios menores en anotaciones

**Antes (funciona pero anticuado):**
```java
@Controller
@RequestMapping(value="/rest/equipo")
public class EquiposController {
    
    @RequestMapping(value="/buscarTodos/{idTemporada}", 
                    method = RequestMethod.GET,
                    headers="Accept=application/json")
    @ResponseBody
    public ResponseEntity<List<Equipo>> ListEquipos(...) {
```

**Después (moderno y más limpio):**
```java
@RestController  // Combina @Controller + @ResponseBody
@RequestMapping("/rest/equipo")
public class EquiposController {
    
    @GetMapping("/buscarTodos/{idTemporada}")  // Más conciso
    public ResponseEntity<List<Equipo>> listEquipos(...) {
```

### 4.2 Lista de Controllers a actualizar

| Controller | Cambio principal |
|------------|------------------|
| LoginController | @Controller → @RestController, quitar @ResponseBody |
| UserController | @Controller → @RestController |
| EquiposController | @Controller → @RestController |
| TemporadaController | @Controller → @RestController |
| DraftController | @Controller → @RestController |
| CatalogosController | @Controller → @RestController |
| AdminUserController | @Controller → @RestController |
| SofifaProxyController | Ya usa @Controller, actualizar |
| TestController | Ya usa @RestController ✓ |
| SponsorController | Ya usa @RestController ✓ |

---

## Paso 5: Actualizar LoginServiceImpl

El UserDetailsService debe seguir funcionando, pero actualizar imports:

**Archivo:** `src/main/java/com/app/service/login/LoginServiceImpl.java`

```java
package com.app.service.login;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.app.dao.login.LoginDao;
import com.app.modelo.login.UserInfo;

@Service
public class LoginServiceImpl implements UserDetailsService {
    // El código interno puede quedarse igual
}
```

---

## Paso 6: Eliminar web.xml

Spring Boot 3 no necesita `web.xml`. Puedes eliminarlo:

```powershell
Remove-Item "src\main\webapp\WEB-INF\web.xml"
```

---

## Paso 7: Compilar y probar localmente

### 7.1 Compilar
```powershell
cd c:\Users\mi17040\Documents\fifa\fifaXGamesrs
mvn clean package -DskipTests
```

### 7.2 Si hay errores de compilación
Los errores más comunes serán:
- `javax.servlet` no encontrado → Cambiar a `jakarta.servlet`
- Clase no encontrada → Verificar imports

### 7.3 Probar localmente (opcional)
```powershell
# Si quieres probar como JAR embebido
mvn spring-boot:run

# O generar el WAR
mvn clean package
# El WAR estará en: target/fifaapp.war
```

---

## Paso 8: Deploy en JVMHost

### 8.1 Configurar Java 17 y Tomcat 10 en JVMHost
1. Ir al panel de JVMHost
2. Seleccionar JDK: `jdk-17.x`
3. Seleccionar Tomcat: `apache-tomcat-10.x`
4. Guardar cambios
5. Reiniciar el servicio

### 8.2 Subir el WAR
1. Ir a Tomcat Manager: `http://fifaxgamers.jvmhost.net:12207/manager`
2. Undeploy la aplicación anterior (si existe)
3. En "WAR file to deploy" → Seleccionar `target/fifaapp.war`
4. Click en "Deploy"

### 8.3 Verificar
```
https://fifaxgamers.jvmhost.net/fifaapp/test
```
Debería devolver: `{"1": "OK"}`

---

## Paso 9: Configurar perfil de producción

### 9.1 En JVMHost, configurar variable de entorno:
```
SPRING_PROFILES_ACTIVE=prod
```

O en el Tomcat Manager, agregar al contexto:
```xml
<Context>
    <Parameter name="spring.profiles.active" value="prod"/>
</Context>
```

---

## Checklist final

- [ ] Backup del proyecto original
- [ ] pom.xml actualizado a Spring Boot 3.3
- [ ] application.properties actualizado
- [ ] Imports javax → jakarta
- [ ] Clases de configuración antiguas eliminadas
- [ ] Nueva clase FifaXGamersApplication
- [ ] Nueva SecurityConfig
- [ ] Nueva WebConfig
- [ ] Controllers actualizados (@RestController)
- [ ] Compilación exitosa (mvn clean package)
- [ ] Tests pasando
- [ ] JVMHost configurado con Java 17 + Tomcat 10
- [ ] WAR desplegado
- [ ] Endpoints funcionando

---

## Troubleshooting

### Error: "javax.servlet not found"
**Solución:** Cambiar imports a `jakarta.servlet`

### Error: "WebSecurityConfigurerAdapter not found"
**Solución:** Usar la nueva configuración SecurityFilterChain (ya incluida)

### Error: "ClassNotFoundException: com.mysql.jdbc.Driver"
**Solución:** El nuevo driver es `com.mysql.cj.jdbc.Driver` (ya configurado)

### Error de conexión a BD
**Verificar:**
1. URL correcta en application-prod.properties
2. Credenciales correctas
3. Puerto 3306 accesible

### Error: "No main manifest attribute"
**Solución:** Asegurar que el packaging es `war` en pom.xml y que tienes `SpringBootServletInitializer`

---

## Archivos creados en esta migración

```
fifaXGamesrs/
├── pom-springboot3.xml              ← Nuevo POM (renombrar a pom.xml)
├── src/main/java/
│   └── com/fifaxgamers/
│       ├── FifaXGamersApplication.java    ← Clase principal
│       └── config/
│           ├── SecurityConfig.java        ← Nueva seguridad
│           └── WebConfig.java             ← Nueva config MVC
└── src/main/resources/
    ├── application-springboot3.properties ← Config dev (renombrar)
    └── application-prod.properties         ← Config producción
```
