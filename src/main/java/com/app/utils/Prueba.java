
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
 
public class Prueba {
 
    public static void main( String []arg ){
        try
        {
            //Se carga el driver JDBC
            DriverManager.registerDriver( new oracle.jdbc.driver.OracleDriver() );
             
            //nombre del servidor
            String nombre_servidor = "127.0.0.1";
            //numero del puerto
            String numero_puerto = "1521";
            //SID
            String sid = "xe";
            //URL "jdbc:oracle:thin:@nombreServidor:numeroPuerto:SID"
            String url = "jdbc:oracle:thin:@" + nombre_servidor + ":" + numero_puerto + ":" + sid;
 
            //Nombre usuario y password
            String usuario = "DBAP1";
            String password = "proyecto1";
 
            //Obtiene la conexion
            Connection conexion = DriverManager.getConnection( url, usuario, password );
             
            //Para realiza una consulta
            Statement sentencia = conexion.createStatement();
            ResultSet resultado = sentencia.executeQuery( "SELECT * FROM TIPO_OPERACION" );
             
            //Se recorre el resultado obtenido
            while ( resultado.next() )
            {
                //Se imprime el resultado colocando
                //Para obtener la primer columna se coloca el numero 1 y para la segunda columna 2 el numero 2
                //System.out.println ( resultado.getInt( 1 ) + "\t" + resultado.getString( 2 ) );
            }
             
            //Cerramos la sentencia
            sentencia.close();
        }catch( Exception e ){
            e.printStackTrace();
        }
    }
}