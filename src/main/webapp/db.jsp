<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%

Connection con = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/library?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String user = "root";
    String pass = "Qwerty@123";
    con = DriverManager.getConnection(url,user,pass);
} catch(Exception e) {
    out.println("<div style='padding:12px;background:#fee;border:1px solid #fbb;color:#700;'>DB Error: "+e.getMessage()+"</div>");
}
%>
