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
        GrupoService gservice = new GrupoService(pool.getConnection());

        String nombreGrupo = null;

        boolean matricular = Boolean.parseBoolean(request.getParameter("matricular")); 
        boolean desmatricular = Boolean.parseBoolean(request.getParameter("desmatricular")); 
        boolean listarPorGrupo = Boolean.parseBoolean(request.getParameter("listarPorGrupo")); 

%>

<body>
<% if (matricular) { %>
    <h1 class="text-center fw-bold pt-4">
    Matricular alumno
    </h1>
    <form class="w-50 mx-auto" method="post" action="matriculacion.jsp">
        <div class="form-floating mb-3">
        <input type="number" class="form-control" id="id" name="id" placeholder="ID del alumno">
        <label for="ID del alumno">ID del alumno</label>
        </div>
        <div class="form-floating mb-3">
        <input type="number" class="form-control" id="idGrupo" name="idGrupo" placeholder="ID del grupo">
        <label for="ID del grupo">ID del grupo</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="matricularAlumno" value="true">
		<input type="submit" value="Matricular">
        </div>
	</form>
<%}%>
<% if (desmatricular) { %>
    <h1 class="text-center fw-bold pt-4">
    Desmatricular alumno
    </h1>
    <form class="w-50 mx-auto" method="post" action="matriculacion.jsp">
        <div class="form-floating mb-3">
        <input type="number" class="form-control" id="id" name="id" placeholder="ID del alumno">
        <label for="ID del alumno">ID del alumno</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="desmatricularAlumno" value="true">
		<input type="submit" value="Desmatricular">
        </div>
	</form>
<%}%>
<% if (listarPorGrupo) { %>
    <h1 class="text-center fw-bold pt-4">
    Listar por grupo
    </h1>
    <form class="w-50 mx-auto" method="post" action="matriculacion.jsp">
        <div class="form-floating mb-3">
        <input type="number" class="form-control" id="idGrupo" name="idGrupo" placeholder="ID del grupo">
        <label for="ID del grupo">ID del grupo</label>
        </div>
        <div class="form floating mb-3 text-center">
        <input type="hidden" name="listarPorGrupo" value="true">
		<input type="submit" value="Listar">
        </div>
	</form>
<%}%>
<div class="container text-center">
    <div class="pt-5 pb-5">
        <form method="POST" action="matriculacion.jsp">
        <button type="submit" class="btn btn-primary btn-lg btn-block">Volver</button>
        </form>   
    </div>    
</div>
    <h2 class="text-center fw-bold pt-4">
    Grupos
    </h2> 
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

    <h2 class="text-center fw-bold pt-4">
    Alumnos
    </h2> 
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