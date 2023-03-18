package modelos.alumnos;
public class Alumno {
    long id;
    String nombre;
    String apellidos;
    long idGrupo;

    public Alumno(){
        this(0,"","");
    }

    public Alumno(long id, String nombre, String apellidos){
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
    }

    public Alumno(long id, String nombre, String apellidos, long idGrupo){
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.idGrupo = idGrupo;
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

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public long getIdGrupo() {
        return idGrupo;
    }

    public void setIdGrupo(long idGrupo) {
        this.idGrupo = idGrupo;
    }


    @Override
    public String toString() {
        return String.format("ID: %d, Nombre: %s, Apellidos: %s, Grupo: %d", this.id, this.nombre, this.apellidos, idGrupo);
    }
}
