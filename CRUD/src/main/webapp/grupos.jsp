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
<body>
<%      String url = "jdbc:mysql://localhost:3306/alumnos";
        String usuario = "jesus";
        String clave = "admin";
        ConnectionPool pool = new ConnectionPool(url, usuario, clave);
        GrupoService gservice = new GrupoService(pool.getConnection());

        boolean añadirGrupo = Boolean.parseBoolean(request.getParameter("añadirGrupo")); 
        boolean modificarGrupo = Boolean.parseBoolean(request.getParameter("modificarGrupo")); 
        boolean borrarGrupo = Boolean.parseBoolean(request.getParameter("borrarGrupo")); 
        String idString = request.getParameter("id"); 
        long id = 0; 
        if (idString!=null) {
            id = Long.valueOf(idString);
        }
        String nombreGrupo = (request.getParameter("nombreGrupo"));
        String profesor = (request.getParameter("profesor")); 
        if (añadirGrupo) {
        gservice.create(nombreGrupo,profesor);
        }
        if (modificarGrupo) {
            try {
            gservice.update(id,nombreGrupo,profesor);
            } catch (Exception e) {
                out.println("Error: no se pudo modificar el grupo, asegurese de introducir bien los datos");
            }
        }
        if (borrarGrupo) {
            try {
            gservice.delete(id);
            } catch (Exception e) {
                out.println("Error: no se pudo borrar el grupo, asegurese de introducir bien los datos");
            }
        }
%>
<h1 class="text-center fw-bold pt-4">
Gestión de grupos
</h1>

<div class="container text-center">
    <div class="row pt-5">
        <div class="col">
            <form method="POST" action="menuGrupo.jsp">
                <input type="hidden" name="añadir" value="true">
                <button type="submit" class="btn btn-success btn-lg btn-block">Añadir grupo</button>
            </form>
        </div>
        <div class="col">
            <form method="POST" action="menuGrupo.jsp">
                <input type="hidden" name="modificar" value="true">
                <button type="submit" class="btn btn-warning btn-lg btn-block">Modificar grupo</button>
            </form>
        </div>
        <div class="col">
            <form method="POST" action="menuGrupo.jsp">
                <input type="hidden" name="borrar" value="true">
                <button type="submit" class="btn btn-danger btn-lg btn-block">Eliminar grupo</button>
            </form>    
        </div>
    </div>
    <div class="pt-5 pb-5">
        <form method="POST" action="index.jsp">
        <button type="submit" class="btn btn-primary btn-lg btn-block">Volver</button>
        </form>   
    </div>    
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