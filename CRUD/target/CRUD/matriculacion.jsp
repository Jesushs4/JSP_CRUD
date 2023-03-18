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
        MatriculacionService mservice = new MatriculacionService(pool.getConnection());

        String nombreGrupo = null;
        boolean matricularAlumno = Boolean.parseBoolean(request.getParameter("matricularAlumno")); 
        boolean desmatricularAlumno = Boolean.parseBoolean(request.getParameter("desmatricularAlumno")); 
        boolean listarPorGrupo = Boolean.parseBoolean(request.getParameter("listarPorGrupo")); 
        String idString = request.getParameter("id");
        
        long id = 0; 
        if (idString!=null) {
            id = Long.valueOf(idString);
        }

        String idGrupoString = request.getParameter("idGrupo"); 
        long idGrupo = 0; 
        if (idGrupoString!=null) {
            idGrupo = Long.valueOf(idGrupoString);
        }
        
        if (matricularAlumno) {
            try {
        mservice.assign(id,idGrupo);
            } catch (Exception e) {
                out.println("Error: no se pudo matricular al alumno, asegurese de introducir bien los datos");
            }
        }
        if (desmatricularAlumno) {
            try {
            mservice.unassign(id);
            } catch (Exception e) {
                out.println("Error: no se pudo desmatricular al alumno, asegurese de introducir bien los datos");
            }
        }


        AlumnosService aservice = new AlumnosService(pool.getConnection());
%>
<h1 class="text-center fw-bold pt-4">
Gestión de matriculación
</h1>

<div class="container text-center">
    <div class="row pt-5">
        <div class="col">
            <form method="POST" action="menuMatriculacion.jsp">
                <input type="hidden" name="matricular" value="true">
                <button type="submit" class="btn btn-success btn-lg btn-block">Matricular alumno</button>
            </form>
        </div>
        <div class="col">
            <form method="POST" action="menuMatriculacion.jsp">
                <input type="hidden" name="desmatricular" value="true">
                <button type="submit" class="btn btn-warning btn-lg btn-block">Desmatricular alumno</button>
            </form>
        </div>
        <div class="col">
            <form method="POST" action="menuMatriculacion.jsp">
                <input type="hidden" name="listarPorGrupo" value="true">
                <button type="submit" class="btn btn-info btn-lg btn-block">Listar por grupo</button>
            </form>    
        </div>
    </div>
    <div class="pt-5 pb-5">
        <form method="POST" action="index.jsp">
        <button type="submit" class="btn btn-primary btn-lg btn-block">Volver</button>
        </form>   
    </div>    
</div>

    <%  
            if (listarPorGrupo) { 
                ArrayList<Alumno> alumnos = aservice.requestAll();
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
                                if (a.getIdGrupo() == idGrupo) {
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
                        <% } } %>
                    </tbody>
                </table>
        <%  } } else {
    
    ArrayList<Alumno> alumnos = aservice.requestAll();
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
            <% } }%>
</body>