<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Pagina de Login</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<!-- vinculo a bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<!-- Temas-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">
<!-- se vincula al hoja de estilo para definir el aspecto del formulario de login-->
<link rel="stylesheet" href="<c:url value='/css/estilos1.css'/>"
	type="text/css" />

<link rel="stylesheet" href="<c:url value='/css/estilos.css'/>"
	type="text/css" />
</head>

<body onload='document.f.j_username.focus();'>

<%-- 	<img src="<c:url value='/imagenes/xfiles.jpg'/>" align="right" /> --%>

	

	<div id="Contenedor">
		
		<div class="ContentForm">
			<form action="<c:url value='/paginas/login.jsp'/>" method="post" name="f">
			<div class="Icon">
                    <!--Icono de usuario-->
                   <span class="glyphicon glyphicon-user"></span>
                 </div>
			
				<c:if test="${param.login_error ne null}">
					<font color="orange"> El intento de conectar no tuvo éxito,
						intentelo de nuevo.<br /> Razón:
						${SPRING_SECURITY_LAST_EXCEPTION.message}
					</font>
				</c:if>
				<div class="input-group input-group-lg">
					<span class="input-group-addon" id="sizing-addon1"><i
						class="glyphicon glyphicon-envelope"></i></span> 
						<input type="text"
						class="form-control" name="username" placeholder="Usuario"
						id="Correo" aria-describedby="sizing-addon1" value="${cookie.SPRING_SECURITY_LAST_USERNAME.value}"
						required>

				</div>
				<br>
				<div class="input-group input-group-lg">
					<span class="input-group-addon" id="sizing-addon1"><i
						class="glyphicon glyphicon-lock"></i></span> <input type="password"
						name="password" class="form-control" placeholder="******"
						aria-describedby="sizing-addon1" required>
				</div>
				<br>
				<button class="btn btn-lg btn-primary btn-block btn-signin"
					id="IngresoLog" type="submit">Entrar</button>
				<div class="opcioncontra">
					<a  href='<c:url value="/usermanager/signup" />'>Sign up</a>
				</div>
			</form>
		</div>
	</div>

</body>
<!-- vinculando a libreria Jquery-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- Libreria java scritp de bootstrap -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
</html>




