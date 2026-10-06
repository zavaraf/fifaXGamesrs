# Análisis Técnico del Backend - FIFA X Gamers

**Fecha del análisis:** 23 de julio de 2026  
**Objetivo:** Migración del backend manteniendo Java

---

## 1. Información General

| Característica | Valor |
|----------------|-------|
| **Nombre del proyecto** | fifaapp |
| **Tipo de proyecto** | Maven |
| **Empaquetado** | WAR |
| **Versión de Java declarada** | 1.8 |
| **Versión de compilación** | 1.7 (maven-compiler-plugin) |
| **Framework principal** | Spring MVC |
| **Versión de Spring Framework** | 4.2.6.RELEASE |
| **Versión de Spring Security** | 4.1.0.RELEASE |
| **Servidor de aplicaciones** | Tomcat (implícito por WAR) |
| **Base de datos** | MySQL |
| **Driver JDBC** | mysql-connector-java 5.1.44 |

### ⚠️ Inconsistencia detectada
El `pom.xml` declara `java.version=1.8` pero el plugin de compilación usa `source=1.7` y `target=1.7`.

---

## 2. Dependencias

### Spring Framework
| Dependencia | Versión | Estado |
|-------------|---------|--------|
| spring-webmvc | 4.2.6.RELEASE | ⚠️ **OBSOLETA** (última: 6.x) |
| spring-core | 4.2.6.RELEASE | ⚠️ **OBSOLETA** |
| spring-security-web | 4.1.0.RELEASE | ⚠️ **OBSOLETA** (última: 6.x) |
| spring-security-config | 4.1.0.RELEASE | ⚠️ **OBSOLETA** |
| spring-security-taglibs | 4.1.0.RELEASE | ⚠️ **OBSOLETA** |

### Persistencia
| Dependencia | Versión | Estado |
|-------------|---------|--------|
| mysql-connector-java | 5.1.44 | ⚠️ **OBSOLETA** (última: 8.x) |
| ojdbc14 (Oracle) | 10.2.0.4.0 | ⚠️ **MUY OBSOLETA** |

**Nota:** No se utiliza Hibernate, JPA ni MyBatis. El acceso a datos es mediante **JDBC puro con JdbcTemplate**.

### Serialización JSON
| Dependencia | Versión | Estado |
|-------------|---------|--------|
| jackson-core | 2.4.1 | ⚠️ **OBSOLETA** (última: 2.17.x) |
| jackson-databind | 2.4.1.1 | ⚠️ **OBSOLETA** |
| gson | 2.8.6 | ⚠️ Desactualizada (última: 2.11.x) |

### Logging
| Dependencia | Versión | Estado |
|-------------|---------|--------|
| slf4j-api | 1.7.5 | ⚠️ **OBSOLETA** (última: 2.x) |
| logback-classic | 1.0.13 | ⚠️ **OBSOLETA** (última: 1.5.x) |

### Seguridad/JWT
| Dependencia | Versión | Estado |
|-------------|---------|--------|
| jjwt-api | 0.11.5 | ✅ Relativamente actual |
| jjwt-impl | 0.11.5 | ✅ Relativamente actual |
| jjwt-jackson | 0.11.5 | ✅ Relativamente actual |

### Servlet/Web
| Dependencia | Versión | Estado |
|-------------|---------|--------|
| javax.servlet-api | 3.1.0 | ⚠️ **OBSOLETA** (migrar a jakarta) |
| javax.servlet.jsp-api | 2.3.1 | ⚠️ No necesaria (solo backend) |
| jstl | 1.2 | ⚠️ No necesaria (solo backend) |

### Testing
| Dependencia | Versión | Estado |
|-------------|---------|--------|
| junit | 3.8.1 | ⚠️ **MUY OBSOLETA** (última: 5.x) |

### Resumen de dependencias obsoletas críticas
- **11 de 15** dependencias principales están obsoletas
- Todas las dependencias de Spring están 2 versiones mayores atrasadas
- El driver MySQL está desactualizado y tiene vulnerabilidades conocidas

---

## 3. Arquitectura

### Patrón arquitectónico
El proyecto sigue una arquitectura **MVC en capas**:

```
┌─────────────────────────────────────────────────────────┐
│                    Controllers (REST API)                │
├─────────────────────────────────────────────────────────┤
│                    Services (Interfaces)                 │
├─────────────────────────────────────────────────────────┤
│                 Service Implementations                  │
├─────────────────────────────────────────────────────────┤
│                    DAO (Interfaces)                      │
├─────────────────────────────────────────────────────────┤
│                  DAO Implementations                     │
│               (JdbcTemplate + SQL directo)               │
├─────────────────────────────────────────────────────────┤
│                       MySQL                              │
└─────────────────────────────────────────────────────────┘
```

### Árbol de paquetes

```
src/main/java/
├── com/
│   ├── app/
│   │   ├── controller/          # Controllers REST
│   │   │   ├── AdminUserController.java
│   │   │   ├── CatalogosController.java
│   │   │   ├── DraftController.java
│   │   │   ├── EquiposController.java
│   │   │   ├── LoginController.java
│   │   │   ├── SofifaProxyController.java
│   │   │   ├── SponsorController.java
│   │   │   ├── TemporadaController.java
│   │   │   ├── TestController.java
│   │   │   ├── UserController.java
│   │   │   └── UserManagerController.java
│   │   │
│   │   ├── dao/                 # Interfaces DAO
│   │   │   ├── impl/            # Implementaciones DAO
│   │   │   └── login/           # DAO de autenticación
│   │   │
│   │   ├── enums/               # Enumeraciones
│   │   │   ├── CodigoResponse.java
│   │   │   ├── Salarios.java
│   │   │   ├── TipoIngreso.java
│   │   │   └── TipoTorneoEnum.java
│   │   │
│   │   ├── modelo/              # Entidades/POJOs
│   │   │   └── login/           # Modelos de autenticación
│   │   │
│   │   ├── service/             # Interfaces de servicio
│   │   │   ├── impl/            # Implementaciones
│   │   │   └── login/           # Services de autenticación
│   │   │
│   │   ├── utils/               # Utilidades
│   │   │   └── ApplicationConfig.java  # Configuración DataSource
│   │   │
│   │   ├── validator/           # Validadores
│   │   │   └── SignupValidator.java
│   │   │
│   │   └── web/                 # Controllers de vistas (NO API)
│   │       └── IndexController.java
│   │
│   └── spring/
│       ├── AppInitializer.java              # Inicializador Web
│       ├── ConfiguracionMVC.java            # Config Spring MVC
│       ├── ConfiguracionSpringSecurity.java # Config Seguridad
│       └── model/                           # Modelo Spring Security
│           ├── User.java
│           └── UserDetails.java
```

### Capas detectadas

| Capa | Existe | Cantidad |
|------|--------|----------|
| Controllers | ✅ | 12 |
| Services (interfaces) | ✅ | 10 |
| Services (impl) | ✅ | 9 |
| DAO (interfaces) | ✅ | 11 |
| DAO (impl) | ✅ | 9 |
| Repository (Spring Data) | ❌ | 0 |
| Entity (JPA) | ❌ | 0 |
| Modelo/POJO | ✅ | ~25 |
| DTO | ⚠️ Parcial | Mezclados con modelos |
| Utils | ✅ | 6 |
| Validators | ✅ | 1 |
| Configuración XML | ⚠️ Mínima | Solo web.xml básico |
| Configuración Java | ✅ | 3 clases |

---

## 4. APIs

### Resumen de Controllers REST

| Controller | Base Path | Anotación | Endpoints aprox. |
|------------|-----------|-----------|------------------|
| LoginController | `/rest` | `@Controller` | 3 |
| UserController | `/rest` | `@Controller` | 12 |
| EquiposController | `/rest/equipo` | `@Controller` | 7 |
| TemporadaController | `/rest/temporada` | `@Controller` | 25+ |
| DraftController | `/rest/draft` | `@Controller` | 14 |
| CatalogosController | `/rest/catalogs` | `@Controller` | 6 |
| SponsorController | `/rest/sponsor` | `@RestController` | 11 |
| AdminUserController | `/rest/adminUser` | `@Controller` | 3 |
| SofifaProxyController | `/rest/sofifa` | `@Controller` | 15+ |
| TestController | `/test` | `@RestController` | 3 |
| UserManagerController | `/usermanager` | `@Controller` | 2 |
| IndexController | `/` | `@Controller` | ~12 (vistas, NO API) |

### Estadísticas API

| Métrica | Valor |
|---------|-------|
| **Controllers REST** | 11 |
| **Controllers de vistas** | 1 (IndexController - ignorar) |
| **Endpoints aproximados** | ~100 |
| **Uso de @Controller** | 10 |
| **Uso de @RestController** | 2 |
| **Devuelven JSON** | ✅ Todos |
| **Uso de ResponseEntity** | ✅ Extensivo |
| **Uso de @ResponseBody** | ✅ En @Controller |
| **CORS habilitado** | ✅ @CrossOrigin en todos |

### Patrones de respuesta

```java
// Patrón común usado
@RequestMapping(value="/path", method = RequestMethod.GET, headers="Accept=application/json")
@ResponseBody
public ResponseEntity<List<Entity>> method() {
    List<Entity> list = service.findAll();
    if(list.isEmpty()) {
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
    return new ResponseEntity<>(list, HttpStatus.OK);
}
```

### ⚠️ Problemas detectados en APIs

1. **Mezcla de @Controller con @ResponseBody** en lugar de usar @RestController
2. **Uso de headers="Accept=application/json"** (redundante con produces)
3. **PathVariable en URL para datos sensibles** (passwords, tokens)
4. **System.out.println para logging** en lugar de SLF4J
5. **Credenciales hardcodeadas** en ApplicationConfig

---

## 5. Persistencia

### Tecnología de acceso a datos

| Tecnología | Usado |
|------------|-------|
| **Hibernate** | ❌ No |
| **JPA / EntityManager** | ❌ No |
| **Spring Data JPA** | ❌ No |
| **MyBatis** | ❌ No |
| **JDBC puro** | ✅ Sí |
| **JdbcTemplate** | ✅ Sí |
| **Stored Procedures** | ✅ Sí |

### Componentes de persistencia

| Componente | Usado |
|------------|-------|
| EntityManager | ❌ |
| SessionFactory | ❌ |
| JdbcTemplate | ✅ |
| DataSource | ✅ |
| RowMapper | ✅ |
| StoredProcedure | ✅ |

### Ejemplo de patrón DAO actual

```java
@Component
public class EquipoDaoImpl implements EquipoDao {
    @Autowired
    JdbcTemplate jdbcTemplate;
    
    public List<Equipo> buscarTodos(long idTemporada) {
        String query = "SELECT ... FROM equipos ...";
        Collection equipos = jdbcTemplate.query(query, new RowMapper() {
            public Object mapRow(ResultSet rs, int arg1) throws SQLException {
                Equipo equipo = new Equipo();
                equipo.setId(rs.getInt("idEquipo"));
                // ...mapeo manual
                return equipo;
            }
        });
        // Conversión a List
    }
}
```

### ⚠️ Problemas de persistencia

1. **SQL embebido** en strings largos dentro del código Java
2. **Concatenación de parámetros** en queries (riesgo de SQL injection)
3. **RowMapper anónimos** con tipos raw (sin generics)
4. **Sin uso de PreparedStatement** de forma consistente
5. **Stored Procedures con acoplamiento fuerte** a MySQL

---

## 6. Configuración

### Archivos de configuración encontrados

| Archivo | Existe | Propósito |
|---------|--------|-----------|
| `web.xml` | ✅ | Configuración mínima del servlet container |
| `applicationContext.xml` | ❌ | No existe (configuración Java) |
| `dispatcher-servlet.xml` | ❌ | No existe (configuración Java) |
| `spring-servlet.xml` | ❌ | No existe (configuración Java) |
| `application.properties` | ✅ | Configuración de DataSource |
| `application.yml` | ❌ | No existe |

### web.xml (mínimo)

```xml
<web-app version="3.0">
  <display-name>fifaapp</display-name>
  <welcome-file-list>
    <welcome-file>index.jsp</welcome-file>
  </welcome-file-list>
</web-app>
```

El `web.xml` es casi vacío porque la configuración se hace vía `WebApplicationInitializer`.

### application.properties

```properties
# Configuración local
jdbc.driverClassName=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/fifaxgamersbd
jdbc.userName=root
jdbc.pass=root

# Configuración producción
prod.jdbc.url=jdbc:mysql://ud4.nodecluster.net:3306/fifaxgam_fifaxgamersbd
prod.jdbc.userName=fifaxgam_fifaApp
prod.jdbc.pass=FifaRoot#

isProd=true
```

### Clases de configuración Java

| Clase | Propósito |
|-------|-----------|
| `AppInitializer` | Reemplaza web.xml, registra DispatcherServlet y filtros |
| `ConfiguracionMVC` | Configura Spring MVC, ViewResolver, CORS, recursos estáticos |
| `ConfiguracionSpringSecurity` | Configura autenticación, autorización, sesiones |
| `ApplicationConfig` | Configura DataSource y JdbcTemplate |

### ⚠️ Problemas de configuración

1. **WebMvcConfigurerAdapter** deprecated (usar `WebMvcConfigurer`)
2. **WebSecurityConfigurerAdapter** deprecated (usar `SecurityFilterChain`)
3. **Credenciales en texto plano** en properties y código
4. **Sin perfiles de Spring** (@Profile) para ambientes
5. **CORS configurado estáticamente** con dominios hardcodeados

---

## 7. Seguridad

### Tecnologías de seguridad

| Tecnología | Usado | Detalles |
|------------|-------|----------|
| Spring Security | ✅ | 4.1.0.RELEASE |
| OAuth 2.0 | ❌ | No implementado |
| JWT | ✅ | jjwt 0.11.5 |
| LDAP | ❌ | No implementado |
| Filtros propios | ⚠️ | Solo DelegatingFilterProxy |
| Interceptores | ❌ | No usados |

### Configuración actual

```java
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class ConfiguracionSpringSecurity extends WebSecurityConfigurerAdapter {
    
    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
            .antMatchers("/rest/**").permitAll()  // ⚠️ APIs públicas
            .antMatchers("/**").access("hasAnyRole('Admin','Manager','Usuario')")
            // ...
        http.csrf().disable();  // ⚠️ CSRF deshabilitado
    }
}
```

### ⚠️ Problemas de seguridad

| Problema | Severidad | Descripción |
|----------|-----------|-------------|
| CSRF deshabilitado | ⚠️ Media | Vulnerable a ataques CSRF |
| APIs públicas | ⚠️ Media | `/rest/**` permite acceso sin autenticación |
| Credenciales hardcodeadas | 🔴 Alta | En código y properties |
| System.out para passwords | 🔴 Alta | Logs exponen información sensible |
| Secret key JWT en memoria | ⚠️ Media | Se genera nueva clave por reinicio |
| WebSecurityConfigurerAdapter | ⚠️ Baja | Deprecated en Spring Security 6 |

---

## 8. Dependencias del Servidor

### Análisis de dependencias

| Dependencia | Usado | Impacto en migración |
|-------------|-------|---------------------|
| **Tomcat** | ✅ Implícito (WAR) | Medio - Cambiar a embedded |
| **Servlet API** | ✅ javax.servlet 3.1 | 🔴 Alto - Migrar a jakarta |
| **javax.*** | ✅ Extensivo | 🔴 Alto - Renombrar a jakarta |
| **jakarta.*** | ❌ No usado | Destino de migración |

### Imports javax.* encontrados

```java
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
```

### Impacto

Para migrar a Spring Boot 3 / Spring Framework 6, **todos los imports `javax.*` deben cambiar a `jakarta.*`**. Esto afecta:
- Servlets
- Persistence (si se usa JPA en futuro)
- Validation
- Annotations

---

## 9. Riesgos de Migración

### Matriz de riesgos para Java 21 + Spring Boot 3 + Spring Framework 6

| Riesgo | Dificultad | Descripción | Mitigación |
|--------|------------|-------------|------------|
| **Java 8 → 21** | 🟡 Media | 13 versiones de salto | Migración incremental |
| **Spring 4 → 6** | 🔴 Alta | Cambios breaking, nueva API | Refactorización profunda |
| **javax → jakarta** | 🔴 Alta | Renombrado masivo | Herramientas automáticas |
| **WebSecurityConfigurerAdapter** | 🟡 Media | Deprecated, nueva API | Reescribir seguridad |
| **WebMvcConfigurerAdapter** | 🟢 Baja | Usar interface directa | Cambio menor |
| **mysql-connector 5 → 8** | 🟡 Media | Cambios en URL, timezone | Actualizar configuración |
| **JUnit 3 → 5** | 🟡 Media | API completamente diferente | Reescribir tests |
| **Sin Spring Boot** | 🔴 Alta | Configuración manual actual | Adoptar Spring Boot |
| **SQL embebido** | 🟡 Media | Dificulta mantenimiento | Considerar JPA/MyBatis |
| **Stored Procedures MySQL** | 🟡 Media | Acoplamiento a BD | Evaluar portabilidad |
| **Credenciales hardcodeadas** | 🟡 Media | Problema de seguridad | Variables de entorno |
| **System.out logging** | 🟢 Baja | Cambiar a SLF4J | Refactorización simple |

### Nivel de dificultad global: 🔴 **ALTO**

---

## 10. Estadísticas

### Conteo de componentes

| Tipo | Cantidad |
|------|----------|
| Controllers REST | 11 |
| Controllers Web (vistas) | 1 |
| Services (interfaces) | 10 |
| Services (implementaciones) | 9 |
| DAOs (interfaces) | 11 |
| DAOs (implementaciones) | 9 |
| Modelos/POJOs | ~25 |
| Enums | 4 |
| Utils | 6 |
| Validators | 1 |
| Configuración Java | 4 |
| **Total archivos Java** | **~80** |

### Estimación de líneas de código (backend)

| Componente | LOC estimadas |
|------------|---------------|
| Controllers | ~2,500 |
| Services | ~1,500 |
| DAOs | ~2,000 |
| Modelos | ~1,500 |
| Configuración | ~500 |
| Utils/Otros | ~500 |
| **Total estimado** | **~8,500 LOC** |

### Archivos de configuración

| Tipo | Cantidad |
|------|----------|
| XML (funcional) | 1 (web.xml mínimo) |
| Properties | 1 |
| Clases Java Config | 4 |

---

## 11. Recomendación

### Análisis de opciones

| Opción | Viabilidad | Esfuerzo | Beneficio |
|--------|------------|----------|-----------|
| A) Mantener Spring MVC | ⚠️ Limitada | Bajo | Bajo |
| B) Migrar a Spring Boot | ✅ **Recomendada** | Alto | Alto |
| C) Reescribir parcialmente | ⚠️ Riesgosa | Muy Alto | Medio |
| D) Reescribir completamente | ❌ No recomendada | Extremo | Variable |

### ✅ Recomendación: **B) Migrar a Spring Boot 3**

#### Justificación

1. **Código existente reutilizable**: La arquitectura en capas (Controller → Service → DAO) es compatible con Spring Boot. Los Services y DAOs pueden migrar con cambios mínimos.

2. **~8,500 LOC manejables**: El proyecto no es excesivamente grande. Una migración estructurada es factible.

3. **Sin dependencias complejas**: No usa Hibernate/JPA, lo que simplifica la migración. JdbcTemplate sigue funcionando en Spring 6.

4. **APIs bien definidas**: Los endpoints REST están claramente estructurados con ResponseEntity.

5. **Beneficios de Spring Boot 3**:
   - Tomcat embebido (elimina WAR)
   - Autoconfiguración
   - Actuator para monitoreo
   - Soporte nativo para Docker
   - Java 21 con mejoras de rendimiento

6. **Reescritura completa no justificada**: El código funciona, la lógica de negocio está implementada. Reescribir sería costoso y arriesgado.

---

## 12. Roadmap de Migración

### Fase 1: Preparación (2-3 semanas)
```
□ Actualizar Java 8 → 11 (versión intermedia estable)
□ Actualizar JUnit 3 → JUnit 5
□ Crear suite de tests para APIs críticas
□ Documentar todos los endpoints actuales
□ Configurar control de versiones (si no existe)
□ Crear rama de migración
```

### Fase 2: Actualización de dependencias (2-3 semanas)
```
□ Actualizar mysql-connector-java 5 → 8
□ Actualizar Jackson 2.4 → 2.17
□ Actualizar SLF4J/Logback
□ Actualizar Spring Framework 4 → 5.3 (intermedio)
□ Actualizar Spring Security 4 → 5.8 (intermedio)
□ Resolver deprecations
□ Ejecutar tests y validar funcionamiento
```

### Fase 3: Migración a Spring Boot (3-4 semanas)
```
□ Crear proyecto Spring Boot 3.x nuevo
□ Migrar application.properties
□ Migrar configuración de seguridad (SecurityFilterChain)
□ Migrar configuración MVC
□ Migrar Controllers (cambiar @Controller → @RestController)
□ Migrar Services y DAOs (mínimos cambios)
□ Migrar modelos
□ Renombrar javax.* → jakarta.*
□ Actualizar a Java 21
□ Configurar Spring Boot Actuator
```

### Fase 4: Mejoras de código (2-3 semanas)
```
□ Reemplazar System.out por SLF4J Logger
□ Eliminar credenciales hardcodeadas (usar variables de entorno)
□ Implementar manejo de errores global (@ControllerAdvice)
□ Agregar validación con Bean Validation
□ Documentar APIs con OpenAPI/Swagger
□ Optimizar queries SQL (PreparedStatement)
```

### Fase 5: Containerización (1-2 semanas)
```
□ Crear Dockerfile multistage
□ Crear docker-compose.yml (app + MySQL)
□ Configurar perfiles Spring (dev, prod)
□ Externalizar configuración
□ Probar en contenedores localmente
```

### Fase 6: CI/CD (1-2 semanas)
```
□ Configurar pipeline CI (GitHub Actions/Jenkins/GitLab CI)
□ Agregar stage de build
□ Agregar stage de tests
□ Agregar stage de análisis de código (SonarQube)
□ Agregar stage de construcción de imagen Docker
□ Agregar stage de deploy automático
```

### Fase 7: Despliegue (1 semana)
```
□ Configurar ambiente de staging
□ Deploy en staging y validar
□ Configurar ambiente de producción
□ Migración de datos (si aplica)
□ Deploy en producción
□ Monitoreo post-deploy
```

### Timeline estimado total: **12-18 semanas**

---

## Anexo: Quick Wins (mejoras inmediatas sin migrar)

Estas mejoras pueden hacerse con el código actual:

1. **Seguridad**: Mover credenciales a variables de entorno
2. **Logging**: Reemplazar System.out por Logger
3. **Tests**: Agregar tests unitarios con JUnit 4 (actualizar de 3.8.1)
4. **Documentación**: Agregar Swagger 2.x para documentar APIs
5. **Validación**: Agregar @Valid en DTOs de entrada

---

*Informe generado para migración de backend FIFA X Gamers*
