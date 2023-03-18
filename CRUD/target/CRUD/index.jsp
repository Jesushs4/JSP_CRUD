<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.alumnos.Alumno" %>
<%@ page import="modelos.alumnos.AlumnosService" %>
<%@ page import="modelos.grupos.Grupo" %>
<%@ page import="modelos.grupos.GrupoService" %>
<%@ page import="modelos.matriculacion.MatriculacionService" %>
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
    <h1 class="text-center fw-bold pt-4">
    Menú de gestión del instituto
    </h1>

<div class="container text-center">
    <div class="row pt-5rem">
        <div class="col">
            <form method="POST" action="alumnos.jsp">
                <button type="submit" class="btn btn-primary btn-lg btn-block">Gestión de alumnos</button>
            </form>
        </div>
        <div class="col">
            <form method="POST" action="grupos.jsp">
                <button type="submit" class="btn btn-primary btn-lg btn-block">Gestión de grupos</button>
            </form>
        </div>
        <div class="col">
            <form method="POST" action="matriculacion.jsp">
                <button type="submit" class="btn btn-primary btn-lg btn-block">Matricular alumnos</button>
            </form>    
        </div>
    </div>
</div>
    
</body>
</html>