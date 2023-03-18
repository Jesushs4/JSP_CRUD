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
        GrupoService gservice = new GrupoService(pool.getConnection());

        boolean añadir = Boolean.parseBoolean(request.getParameter("añadir")); 
        boolean modificar = Boolean.parseBoolean(request.getParameter("modificar")); 
        boolean borrar = Boolean.parseBoolean(request.getParameter("borrar")); 
%>        
<body>
<% if (añadir) { %>
    <h1 class="text-center fw-bold pt-4">
    Añadir grupo
    </h1>
    <form class="w-50 mx-auto" method="post" action="grupos.jsp">
        <div class="form-floating mb-3">
        <input type="text" class="form-control" id="nombreGrupo" name="nombreGrupo" placeholder="Nombre del grupo">
        <label for="nombreGrupo">Nombre del grupo</label>
        </div>
        <div class="form-floating mb-3">
        <input type="text" class="form-control" id="profesor" name="profesor" placeholder="Profesor">
        <label for="profesor">Profesor</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="añadirGrupo" value="true">
		<input type="submit" value="Añadir">
        </div>
	</form>
<%}%>
<% if (modificar) { %>
    <h1 class="text-center fw-bold pt-4">
    Modificar grupo
    </h1>
    <form class="w-50 mx-auto" method="post" action="grupos.jsp">
        <div class="form-floating mb-3">
        <input type="number" class="form-control" id="id" name="id" placeholder="ID">
        <label for="id">ID</label>
        </div>
        <div class="form-floating mb-3">
        <input type="text" class="form-control" id="nombreGrupo" name="nombreGrupo" placeholder="Nuevo nombre del grupo">
        <label for="nombreGrupo">Nuevo nombre del grupo</label>
        </div>
        <div class="form-floating mb-3">
        <input type="text" class="form-control" id="profesor" name="profesor" placeholder="Nuevo profesor">
        <label for="profesor">Nuevo profesor</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="modificarGrupo" value="true">
		<input type="submit" value="Modificar">
        </div>
	</form>
<%}%>
<% if (borrar) { %>
    <h1 class="text-center fw-bold pt-4">
    Borrar grupo
    </h1>
    <form class="w-50 mx-auto" method="post" action="grupos.jsp">
        <div class="form-floating mb-3">
        <input type="number" class="form-control" id="id" name="id" placeholder="ID">
        <label for="id">ID</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="borrarGrupo" value="true">
		<input type="submit" value="Borrar">
        </div>
	</form>
<%}%>
<div class="container text-center">
    <div class="pt-5 pb-5">
        <form method="POST" action="grupos.jsp">
        <button type="submit" class="btn btn-primary btn-lg btn-block">Volver</button>
        </form>   
    </div>    

    <%  ArrayList<Grupo> grupos = gservice.requestAll();
            if (grupos.size()==0) {
                out.println("No hay grupos");
            }
            else { %>
                <table class="table text-center">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Grupo</th>
                            <th>Profesor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Grupo g : grupos) { 
                                %>
                            <tr>
                                <td class="bg-primary"><%= g.getId() %></td>
                                <td class="table-primary"><%= g.getNombre() %></td>
                                <td class="table-primary"><%= g.getProfesor() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
</body>