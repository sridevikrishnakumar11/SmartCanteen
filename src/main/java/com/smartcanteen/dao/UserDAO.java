
package com.smartcanteen.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.smartcanteen.model.User;
import com.smartcanteen.util.DBUtil;

public class UserDAO {

    // =========================================================
    // LOGIN / AUTHENTICATION
    // =========================================================

    public User authenticate(String email, String password) {

        if (email == null || password == null) {
            return null;
        }

        email = email.trim().toLowerCase();
        password = password.trim();

        String sql = "SELECT name, email, password, role " +
                     "FROM smartcanteen_users " +
                     "WHERE LOWER(email) = ? AND password = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    System.out.println("[SmartCanteen] Authentication successful for: " + email);
                    return new User(
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                    );
                }
            }

        } catch (SQLException e) {
            System.err.println("[SmartCanteen] Database Authentication Error: "
                    + e.getMessage());
        }

        return null;
    }


    // =========================================================
    // RECORD LOGIN
    // =========================================================

    public boolean recordLogin(User user, String ipAddress, String userAgent) {

        if (user == null) {
            return false;
        }

        String email = user.getEmail() != null
                ? user.getEmail().trim().toLowerCase()
                : "";

        String name = user.getName() != null
                ? user.getName()
                : "";

        String role = user.getRole() != null
                ? user.getRole()
                : "Student";

        String ip = (ipAddress != null && !ipAddress.isBlank())
                ? ipAddress
                : "127.0.0.1";

        String agent = (userAgent != null && !userAgent.isBlank())
                ? userAgent
                : "Web Browser";

        if (agent.length() > 255) {
            agent = agent.substring(0, 255);
        }

        String sql = "INSERT INTO smartcanteen_login_logs " +
                     "(user_email, user_name, role, ip_address, user_agent) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, name);
            ps.setString(3, role);
            ps.setString(4, ip);
            ps.setString(5, agent);

            boolean success = ps.executeUpdate() > 0;
            if (success) {
                System.out.println("[SmartCanteen] Login audit stored successfully");
            }
            return success;

        } catch (SQLException e) {
            System.err.println("[SmartCanteen] Login audit insert failed: "
                    + e.getMessage());
        }

        return false;
    }


    // =========================================================
    // GET RECENT LOGIN RECORDS
    // =========================================================

    public List<Map<String, String>> getRecentLogins(int limit) {

        List<Map<String, String>> list = new ArrayList<>();

        int safeLimit = limit > 0 ? Math.min(limit, 100) : 10;

        String sql = "SELECT user_email, user_name, role, " +
                     "ip_address, login_time " +
                     "FROM smartcanteen_login_logs " +
                     "ORDER BY id DESC " +
                     "LIMIT ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, safeLimit);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, String> row = new HashMap<>();

                    row.put("email", rs.getString("user_email"));
                    row.put("name", rs.getString("user_name"));
                    row.put("role", rs.getString("role"));
                    row.put("ip", rs.getString("ip_address"));

                    Timestamp timestamp =
                            rs.getTimestamp("login_time");

                    if (timestamp != null) {

                        String formattedTime =
                                new SimpleDateFormat(
                                    "yyyy-MM-dd HH:mm:ss"
                                ).format(timestamp);

                        row.put("time", formattedTime);

                    } else {
                        row.put("time", "Just now");
                    }

                    list.add(row);
                }
            }

        } catch (SQLException e) {
            System.err.println("Database Get Logins Error: "
                    + e.getMessage());
        }

        return list;
    }


    // =========================================================
    // REGISTER USER
    // =========================================================

    public boolean registerUser(User user) {

        if (user == null ||
            user.getName() == null ||
            user.getEmail() == null ||
            user.getPassword() == null) {

            return false;
        }

        String name = user.getName().trim();
        String email = user.getEmail().trim().toLowerCase();
        String password = user.getPassword().trim();

        String role = user.getRole();

        if (role == null || role.trim().isEmpty()) {
            role = "Student";
        }

        String sql = "INSERT INTO smartcanteen_users " +
                     "(name, email, password, role) " +
                     "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            System.err.println("[SmartCanteen] Database Registration Error: "
                    + e.getMessage());

            return false;
        }
    }


    // =========================================================
    // CHECK EMAIL
    // =========================================================

    public boolean isEmailRegistered(String email) {

        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        email = email.trim().toLowerCase();

        String sql = "SELECT id " +
                     "FROM smartcanteen_users " +
                     "WHERE LOWER(email) = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {

            System.err.println("Database Email Check Error: "
                    + e.getMessage());
        }

        return false;
    }


    // =========================================================
    // GET ALL USERS
    // =========================================================

    public List<User> getAllUsers() {

        List<User> list = new ArrayList<>();

        String sql = "SELECT name, email, password, role " +
                     "FROM smartcanteen_users " +
                     "ORDER BY id ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                list.add(new User(
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role")
                ));
            }

        } catch (SQLException e) {

            System.err.println("Database Get Users Error: "
                    + e.getMessage());
        }

        return list;
    }
}
