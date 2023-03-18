<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.alumnos.Alumno" %>
<%@ page import="modelos.alumnos.AlumnosService" %>
<%@ page import="modelos.grupos.Grupo" %>
<%@ page import="modelos.grupos.GrupoService" %>
<%@ page import="modelos.matriculacion.MatriculacionService" %>
<%@ page import="modelos.connection.ConnectionPool" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/styles.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    </head>
<%      String url = "jdbc:mysql://localhost:3306/alumnos";
        String usuario = "jesus";
        String clave = "admin";
        ConnectionPool pool = new ConnectionPool(url, usuario, clave);
        AlumnosService aservice = new AlumnosService(pool.getConnection());

        String nombreGrupo = null;

        boolean añadir = Boolean.parseBoolean(request.getParameter("añadir")); 
        boolean modificar = Boolean.parseBoolean(request.getParameter("modificar")); 
        boolean borrar = Boolean.parseBoolean(request.getParameter("borrar")); 

%>

<body>
<% if (añadir) { %>
    <h1 class="text-center fw-bold pt-4">
    Añadir alumno
    </h1>
    <form class="w-50 mx-auto" method="post" action="alumnos.jsp">
        <div class="form-floating mb-3">
        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre">
        <label for="nombre">Nombre</label>
        </div>
        <div class="form-floating mb-3">
        <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Apellidos">
        <label for="apellidos">Apellidos</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="añadirAlumno" value="true">
		<input type="submit" value="Añadir">
        </div>
	</form>
<%}%>
<% if (modificar) { %>
    <h1 class="text-center fw-bold pt-4">
    Modificar alumno
    </h1>
    <form class="w-50 mx-auto" method="post" action="alumnos.jsp">
        <div class="form-floating mb-3">
        <input type="number" class="form-control" id="id" name="id" placeholder="ID">
        <label for="id">ID</label>
        </div>
        <div class="form-floating mb-3">
        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre">
        <label for="nombre">Nuevo nombre</label>
        </div>
        <div class="form-floating mb-3">
        <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Apellidos">
        <label for="apellidos">Nuevos apellidos</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="modificarAlumno" value="true">
		<input type="submit" value="Modificar">
        </div>
	</form>
<%}%>
<% if (borrar) { %>
    <h1 class="text-center fw-bold pt-4">
    Borrar alumno
    </h1>
    <form class="w-50 mx-auto" method="post" action="alumnos.jsp">
        <div class="form-floating mb-3">
        <input type="number" class="form-control" id="id" name="id" placeholder="ID">
        <label for="id">ID</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="borrarAlumno" value="true">
		<input type="submit" value="Borrar">
        </div>
	</form>
<%}%>
<div class="container text-center">
    <div class="pt-5 pb-5">
        <form method="POST" action="alumnos.jsp">
        <button type="submit" class="btn btn-primary btn-lg btn-block">Volver</button>
        </form>   
    </div>    
</div>
    <%  ArrayList<Alumno> alumnos = aservice.requestAll();
            if (alumnos.size()==0) {
                out.println("No hay alumnos");
            }
            else { %>
                <table class="table text-center">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>ID Grupo</th>
                            <th>Grupo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Alumno a : alumnos) { 
                                Statement statement = null;
                                statement = (aservice.getConn()).createStatement();   
                                String sql = "SELECT nombreGrupo FROM grupo WHERE idGrupo=(SELECT idGrupo from alumnos WHERE idGrupo="+a.getIdGrupo()+" LIMIT 1)";
                                // Ejecución de la consulta
                                ResultSet querySet = statement.executeQuery(sql);
                                // Recorrido del resultado de la consulta
                                while(querySet.next()) {
                                    nombreGrupo = querySet.getString("nombreGrupo");

                                } 
                                statement.close();
                                    if (a.getIdGrupo()==0) {
                                    nombreGrupo="Sin grupo";
                                    }
                                %>
                            <tr>
                                <td class="bg-primary"><%= a.getId() %></td>
                                <td class="table-primary"><%= a.getNombre() %></td>
                                <td class="table-primary"><%= a.getApellidos() %></td>
                                <td class="bg-success"><%= a.getIdGrupo() %></td>
                                <td class="table-secondary"><%= nombreGrupo%></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
</body>