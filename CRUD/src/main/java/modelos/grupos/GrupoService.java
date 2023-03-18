package modelos.grupos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class GrupoService {
    Connection conn;
    public GrupoService(Connection conn){
        this.conn = conn;
    }

    public ArrayList<Grupo> requestAll() throws SQLException{
        Statement statement = null;
        ArrayList<Grupo> result = new ArrayList<Grupo>();
        statement = this.conn.createStatement();   
        String sql = "SELECT idGrupo, nombreGrupo, profesor FROM grupo";
        // Ejecución de la consulta
        ResultSet querySet = statement.executeQuery(sql);
        // RecorridGrupoo del resultado de la consulta
        while(querySet.next()) {
            int idGrupo = querySet.getInt("idGrupo");
            String nombreGrupo = querySet.getString("nombreGrupo");
            String profesor = querySet.getString("profesor");
            result.add(new Grupo(idGrupo, nombreGrupo, profesor));
        } 
        statement.close();    
        return result;
    }

    public Grupo requestByidGrupo(long idGrupo) throws SQLException{
        Statement statement = null;
        Grupo result = null;
        statement = this.conn.createStatement();    
        String sql = String.format("SELECT idGrupo, nombreGrupo, grupo FROM grupo WHERE idGrupo=%d", idGrupo);
        // Ejecución de la consulta
        ResultSet querySet = statement.executeQuery(sql);
        // RecorridGrupoo del resultado de la consulta
        if(querySet.next()) {
            String nombreGrupo = querySet.getString("nombreGrupo");
            String profesor = querySet.getString("profesor");
            result = new Grupo(idGrupo, nombreGrupo, profesor);
        }
        statement.close();    
        return result;
    }

    public long create(String nombreGrupo, String profesor) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();    
        String sql = String.format("INSERT INTO grupo (nombreGrupo, profesor) VALUES ('%s', '%s')", nombreGrupo,profesor);
        // Ejecución de la consulta
        int affectedRows = statement.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS);
        if (affectedRows == 0) {
            throw new SQLException("Creating user failed, no rows affected.");
        }
        try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                long idGrupo = generatedKeys.getLong(1);
                statement.close();
                return idGrupo;
            }
            else {
                statement.close();
                throw new SQLException("Creating user failed, no idGrupo obtained.");
            }
        }
    }

    public int update(long idGrupo, String nombreGrupo, String profesor) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();    
        String sql = String.format("UPDATE grupo SET nombreGrupo = '%s', profesor = '%s' WHERE idGrupo=%d", nombreGrupo, profesor, idGrupo);
        // Ejecución de la consulta
        int affectedRows = statement.executeUpdate(sql);
        statement.close();
        if (affectedRows == 0)
            throw new SQLException("Creating user failed, no rows affected.");
        else
            return affectedRows;
    }

    public boolean delete(long idGrupo) throws SQLException{
        Statement statement = null;
        statement = this.conn.createStatement();    
        String sql = String.format("DELETE FROM grupo WHERE idGrupo=%d", idGrupo);
        // Ejecución de la consulta
        int result = statement.executeUpdate(sql);
        statement.close();
        return result==1;
    }
}
