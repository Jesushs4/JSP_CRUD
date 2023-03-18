package modelos.matriculacion;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class MatriculacionService {
    Connection conn;
    public MatriculacionService(Connection conn){
        this.conn = conn;
    }



    public int assign(long idAlumno, long idGrupo) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();    
        String sql = String.format("UPDATE alumnos SET idGrupo = '%s' WHERE id=%d", idGrupo, idAlumno);
        // Ejecución de la consulta
        int affectedRows = statement.executeUpdate(sql);
        statement.close();
        if (affectedRows == 0)
            throw new SQLException("Creating user failed, no rows affected.");
        else
            return affectedRows;
    }

    public boolean unassign(long idAlumno) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();    
        String sql = String.format("UPDATE alumnos SET idGrupo = null WHERE id=%d", idAlumno);
        // Ejecución de la consulta
        int result = statement.executeUpdate(sql);
        statement.close();
        return result==1;
    }
}
