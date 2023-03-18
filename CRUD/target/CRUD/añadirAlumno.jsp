<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.alumnos.Alumno" %>
<%@ page import="modelos.alumnos.AlumnosService" %>
<%@ page import="modelos.grupos.Grupo" %>
<%@ page import="modelos.grupos.GrupoService" %>
<%@ page import="modelos.matriculacion.MatriculacionService" %>
<%@ page import="modelos.connection.ConnectionPool" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/styles.css" type="text/css">
    </head>
<body>
<%      String url = "jdbc:mysql://localhost:3306/alumnos";
        String usuario = "jesus";
        String clave = "admin";
        ConnectionPool pool = new ConnectionPool(url, usuario, clave);
        AlumnosService aservice = new AlumnosService(pool.getConnection());

%>

        <form method="post" action="alumnos.jsp">
            <label for="string">Nombre del alumno:</label>
            <input type="string" id="nombre" name="nombre" required>
            <label for="string">Apellidos del alumno:</label>
            <input type="string" id="apellidos" name="apellidos" required>
            <input type="hidden" id="añadir" name="añadir" value="true">
            <button type="submit">Añadir</button>
        </form>
    <div>
    <%  ArrayList<Alumno> alumnos = aservice.requestAll();
            if (alumnos.size()==0) {
                out.println("No hay alumnos");
            }
            else { %>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Grupo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Alumno a : alumnos) { %>
                            <tr>
                                <td><%= a.getId() %></td>
                                <td><%= a.getNombre() %></td>
                                <td><%= a.getApellidos() %></td>
                                <td><%= a.getIdGrupo() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
    </div>        
</body>