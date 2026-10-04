
package com.smartcanteen.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String HOST =
            "aws-0-ap-south-1.pooler.supabase.com";

    private static final String PASSWORD =
            "web_supabase";

    private static final String PORT = "5432";

    private static final String DATABASE = "postgres";

    private static final String USER =
            "postgres.etangasvkhptwkptxogj";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(
                    "PostgreSQL JDBC driver is missing."
            );
        }
    }

    public static boolean isConfigured() {
        return HOST != null && !HOST.isBlank()
                && PASSWORD != null && !PASSWORD.isBlank()
                && !"YOUR_NEW_DATABASE_PASSWORD".equals(PASSWORD);
    }

    public static Connection getConnection() throws SQLException {

        if (!isConfigured()) {
            throw new SQLException(
                    "Supabase database password is not configured."
            );
        }

        String url = "jdbc:postgresql://"
                + HOST + ":"
                + PORT + "/"
                + DATABASE
                + "?sslmode=require";

        Connection conn = DriverManager.getConnection(
                url,
                USER,
                PASSWORD
        );
        System.out.println("[SmartCanteen] Database connection successful");
        return conn;
    }
}
