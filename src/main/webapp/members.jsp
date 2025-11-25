<%@ include file="db.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html><head><meta charset="utf-8"/><title>Members</title></head><body>
<div class="container">
  <h2>Members</h2>
  <div class="card">
    <form method="post">
      <input type="hidden" name="action" value="add">
      <label>Name</label><input name="name" required>
      <label>Email</label><input name="email" type="email" required>
      <button class="btn" type="submit">Add Member</button>
    </form>
  </div>

  <div style="margin-top:20px;">
    <table>
      <thead><tr><th>ID</th><th>Name</th><th>Email</th></tr></thead>
      <tbody>
      <%
        if("POST".equalsIgnoreCase(request.getMethod()) && "add".equals(request.getParameter("action"))){
          try{
            PreparedStatement ps = con.prepareStatement("INSERT INTO members(name,email) VALUES(?,?)");
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("email"));
            ps.executeUpdate();
            out.println("<div class='success'>Member added</div>");
          }catch(Exception e){ out.println("<div class='error'>"+e.getMessage()+"</div>"); }
        }

        try{
          PreparedStatement ps = con.prepareStatement("SELECT * FROM members");
          ResultSet rs = ps.executeQuery();
          while(rs.next()){
      %>
        <tr>
          <td><%=rs.getInt("id")%></td>
          <td><%=rs.getString("name")%></td>
          <td><%=rs.getString("email")%></td>
        </tr>
      <%
          }
        }catch(Exception e){
          out.println("<tr><td colspan='3'>Error: "+e.getMessage()+"</td></tr>");
        }
      %>
      </tbody>
    </table>
  </div>
</div>
</body></html>
