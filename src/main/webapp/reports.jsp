<%@ include file="db.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html><html><head><meta charset="utf-8"/><title>Reports</title></head><body>
<div class="container">
  <h2>Reports</h2>
  <div class="card">
    <h4>Overdue books</h4>
    <table>
      <thead><tr><th>Issue ID</th><th>Member</th><th>Book</th><th>Due Date</th></tr></thead>
      <tbody>
      <%
        try{
          PreparedStatement ps = con.prepareStatement("SELECT i.id,m.name,b.title,i.due_date FROM issues i JOIN members m ON i.member_id=m.id JOIN books b ON i.book_id=b.id WHERE i.returned=0 AND i.due_date < CURDATE()");
          ResultSet rs = ps.executeQuery();
          while(rs.next()){
            out.println("<tr><td>"+rs.getInt("id")+"</td><td>"+rs.getString("name")+"</td><td>"+rs.getString("title")+"</td><td>"+rs.getDate("due_date")+"</td></tr>");
          }
        }catch(Exception e){ out.println("<tr><td colspan='4'>"+e.getMessage()+"</td></tr>"); }
      %>
      </tbody>
    </table>
  </div>
</div>
</body></html>
