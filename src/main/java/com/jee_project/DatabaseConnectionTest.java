package com.jee_project;

import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

@WebServlet(value = "/test-db")
public class DatabaseConnectionTest extends HttpServlet {

    @Resource(name = "smsDS")
    private DataSource dataSource;

    @PersistenceContext(unitName = "smsPU")
    private EntityManager entityManager;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>Database Connection Test</h1>");

        // Test 1: DataSource Connection
        out.println("<h2>Test 1: DataSource Connection</h2>");
        testDataSource(out);

        // Test 2: EntityManager
        out.println("<h2>Test 2: EntityManager</h2>");
        testEntityManager(out);

        out.println("</body></html>");
    }

    private void testDataSource(PrintWriter out) {
        if (dataSource == null) {
            out.println("<p style='color:red'>❌ DataSource is NULL</p>");
            return;
        }

        try (Connection conn = dataSource.getConnection()) {
            if (conn != null) {
                DatabaseMetaData metaData = conn.getMetaData();
                out.println("<p style='color:green'>✅ DataSource Connection SUCCESS</p>");
                out.println("<ul>");
                out.println("<li>Database: " + metaData.getDatabaseProductName() + "</li>");
                out.println("<li>Version: " + metaData.getDatabaseProductVersion() + "</li>");
                out.println("<li>Driver: " + metaData.getDriverName() + "</li>");
                out.println("<li>URL: " + metaData.getURL() + "</li>");
                out.println("<li>User: " + metaData.getUserName() + "</li>");
                out.println("</ul>");
            }
        } catch (SQLException e) {
            out.println("<p style='color:red'>❌ DataSource Connection FAILED</p>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace();
        }
    }

    private void testEntityManager(PrintWriter out) {
        if (entityManager == null) {
            out.println("<p style='color:red'>❌ EntityManager is NULL</p>");
            return;
        }

        try {
            // Test native query
            entityManager.createNativeQuery("SELECT 1").getSingleResult();
            out.println("<p style='color:green'>✅ EntityManager Connection SUCCESS</p>");

            // Try to get metadata
            var metamodel = entityManager.getMetamodel();
            out.println("<p>Registered Entities: " + metamodel.getEntities().size() + "</p>");

            if (!metamodel.getEntities().isEmpty()) {
                out.println("<ul>");
                metamodel.getEntities().forEach(entity ->
                        out.println("<li>" + entity.getName() + "</li>")
                );
                out.println("</ul>");
            }

        } catch (Exception e) {
            out.println("<p style='color:red'>❌ EntityManager FAILED</p>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace();
        }
    }
}