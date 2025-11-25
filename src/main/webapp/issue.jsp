<%@ include file="db.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html><html><head><meta charset="utf-8"/><title>Issue Book</title></head><body>
<div class="container">
  <h2>Issue Book</h2>
  <div class="card">
    <form method="post">
      <label>Member</label>
      <select name="member_id" required>
        <option value=''>-- Select --</option>
        <%
          try{
            PreparedStatement ps = con.prepareStatement("SELECT id,name FROM members");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
              out.println("<option value='"+rs.getInt("id")+"'>"+rs.getString("name")+"</option>");
            }
          }catch(Exception e){}
        %>
      </select>

      <label>Book</label>
      <select name="book_id" required>
        <option value=''>-- Select --</option>
        <%
          try{
            PreparedStatement ps = con.prepareStatement("SELECT id,title,total_copies,issued_copies FROM books WHERE total_copies > issued_copies");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
              out.println("<option value='"+rs.getInt("id")+"'>"+rs.getString("title")+"</option>");
            }
          }catch(Exception e){}
        %>
      </select>

      <label>Due date</label>
      <input type="date" name="due" required value="<%= new java.sql.Date(System.currentTimeMillis()).toString() %>">

      <button class="btn" type="submit">Issue</button>
    </form>
  </div>

  <div style="margin-top:20px;">
    <h3>Recently Issued</h3>
    <table>
      <thead><tr><th>ID</th><th>Member</th><th>Book</th><th>Due</th><th>Returned</th></tr></thead>
      <tbody>
      <%
        if("POST".equalsIgnoreCase(request.getMethod())){
          try{
            int mid = Integer.parseInt(request.getParameter("member_id"));
            int bid = Integer.parseInt(request.getParameter("book_id"));
            java.sql.Date due = java.sql.Date.valueOf(request.getParameter("due"));
            PreparedStatement ps = con.prepareStatement("INSERT INTO issues(member_id,book_id,issue_date,due_date,returned) VALUES(?,?,CURDATE(),?,0)");
            ps.setInt(1,mid); ps.setInt(2,bid); ps.setDate(3,due); ps.executeUpdate();
            PreparedStatement up = con.prepareStatement("UPDATE books SET issued_copies = issued_copies + 1 WHERE id=?");
            up.setInt(1,bid); up.executeUpdate();
            out.println("<div class='success'>Book issued</div>");
          }catch(Exception e){ out.println("<div class='error'>"+e.getMessage()+"</div>"); }
        }

        try{
          PreparedStatement ps = con.prepareStatement("SELECT i.id,m.name,b.title,i.due_date,i.returned FROM issues i JOIN members m ON i.member_id=m.id JOIN books b ON i.book_id=b.id ORDER BY i.id DESC LIMIT 10");
          ResultSet rs = ps.executeQuery();
          while(rs.next()){
      %>
        <tr>
          <td><%=rs.getInt("id")%></td>
          <td><%=rs.getString("name")%></td>
          <td><%=rs.getString("title")%></td>
          <td><%=rs.getDate("due_date")%></td>
          <td><%= rs.getInt("returned")==1? "Yes":"No" %></td>
        </tr>
      <%
          }
        }catch(Exception e){ out.println("<tr><td colspan='5'>"+e.getMessage()+"</td></tr>"); }
      %>
      </tbody>
    </table>
  </div>
</div>
</body></html>
