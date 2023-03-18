package modelos.grupos;
public class Grupo {
    long id;
    String nombre;
    String profesor;

    public Grupo(){
        this(0,"","");
    }

    public Grupo(long id, String nombre, String profesor){
        this.id = id;
        this.nombre = nombre;
        this.profesor = profesor;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getProfesor() {
        return profesor;
    }
    
    public void setProfesor(String profesor) {
        this.profesor = profesor;
    }

    @Override
    public String toString() {
        return String.format("ID: %d, Grupo: %s, Profesor: %s", this.id, this.nombre, this.profesor);
    }
}
