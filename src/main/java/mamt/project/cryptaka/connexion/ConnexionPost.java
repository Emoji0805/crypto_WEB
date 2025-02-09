package mamt.project.cryptaka.connexion;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnexionPost {

    private static Connection connection;

    public static Connection getConnectionPost() throws Exception {
        if (connection == null || connection.isClosed()) {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://db:5432/crypto", "postgres", "mams04032003");
            System.out.println("connexion reussi");
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


}
