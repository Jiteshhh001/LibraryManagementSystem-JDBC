<%@ include file="db.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html><head><meta charset="utf-8"/><title>Books</title></head><body>
<div class="container">
  <h2>Books</h2>
  <div class="card">
    <form method="post">
      <input type="hidden" name="action" value="add">
      <label>Title</label><input name="title" required>
      <label>Author</label><input name="author" required>
      <label>Total Copies</label><input name="total" type="number" value="1" min="1" required>
      <button class="btn" type="submit">Add Book</button>
    </form>
  </div>

  <div style="margin-top:20px;">
    <table>
      <thead><tr><th>ID</th><th>Title</th><th>Author</th><th>Total</th><th>Issued</th><th>Actions</th></tr></thead>
      <tbody>
      <%
        if("POST".equalsIgnoreCase(request.getMethod()) && "add".equals(request.getParameter("action"))){
          try{
            PreparedStatement ps = con.prepareStatement("INSERT INTO books(title,author,total_copies,issued_copies) VALUES(?,?,?,0)");
            ps.setString(1, request.getParameter("title"));
            ps.setString(2, request.getParameter("author"));
            ps.setInt(3, Integer.parseInt(request.getParameter("total")));
            ps.executeUpdate();
            out.println("<div class='success'>Book added</div>");
          }catch(Exception e){ out.println("<div class='error'>"+e.getMessage()+"</div>"); }
        }

        try{
          PreparedStatement ps = con.prepareStatement("SELECT * FROM books");
          ResultSet rs = ps.executeQuery();
          while(rs.next()){
      %>
        <tr>
          <td><%=rs.getInt("id")%></td>
          <td><%=rs.getString("title")%></td>
          <td><%=rs.getString("author")%></td>
          <td><%=rs.getInt("total_copies")%></td>
          <td><%=rs.getInt("issued_copies")%></td>
          <td>
            <!-- future: edit / delete -->
          </td>
        </tr>
      <%
          }
        }catch(Exception e){
          out.println("<tr><td colspan='6'>Error: "+e.getMessage()+"</td></tr>");
        }
      %>
      </tbody>
    </table>
  </div>
</div>
</body></html>
