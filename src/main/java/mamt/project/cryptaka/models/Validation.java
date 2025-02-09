package mamt.project.cryptaka.models;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Validation {
    int idValidation;
    String description;

    public Validation(int idValidation, String description) {
        this.idValidation = idValidation;
        this.description = description;
    }

    public Validation() {

    }

    public static List<Validation> getAll(Connection conn) throws SQLException {
        List<Validation> validations = new ArrayList<>();
        String query = "SELECT * FROM validation";

        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Validation validation = new Validation(rs.getInt("idvalidation"), rs.getString("description"));
                validations.add(validation);
            }
        }
        return validations;
    }


    public int getIdValidation() {
        return idValidation;
    }

    public void setIdValidation(int idValidation) {
        this.idValidation = idValidation;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
