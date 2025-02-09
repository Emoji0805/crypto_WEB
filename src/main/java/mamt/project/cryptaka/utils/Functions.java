package mamt.project.cryptaka.utils;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Functions {
    public static Timestamp convertToTimestamp(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        LocalDateTime localDateTime = LocalDateTime.parse(dateStr);
        return Timestamp.valueOf(localDateTime);
    }
}
