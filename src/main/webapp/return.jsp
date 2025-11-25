<%@ include file="db.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html><html><head><meta charset="utf-8"/><title>Return Book</title></head><body>
<div class="container">
  <h2>Return Book</h2>
  <div class="card">
    <form method="post">
      <label>Issue</label>
      <select name="issue_id" required>
        <option value=''>-- Select --</option>
        <%
          try{
            PreparedStatement ps = con.prepareStatement("SELECT i.id,m.name,b.title FROM issues i JOIN members m ON i.member_id=m.id JOIN books b ON i.book_id=b.id WHERE i.returned=0");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
              out.println("<option value='"+rs.getInt("id")+"'>#"+rs.getInt("id")+" - "+rs.getString("name")+" / "+rs.getString("title")+"</option>");
            }
          }catch(Exception e){}
        %>
      </select>
      <button class="btn" type="submit">Return</button>
    </form>
  </div>

  <div style="margin-top:20px;">
    <%
      if("POST".equalsIgnoreCase(request.getMethod())){
        try{
          int iid = Integer.parseInt(request.getParameter("issue_id"));
          // set returned and decrement issued_copies
          PreparedStatement ps = con.prepareStatement("UPDATE issues SET returned=1,return_date=CURDATE() WHERE id=?");
          ps.setInt(1,iid); ps.executeUpdate();
          // find book id
          PreparedStatement ps2 = con.prepareStatement("SELECT book_id FROM issues WHERE id=?");
          ps2.setInt(1,iid); ResultSet rs2 = ps2.executeQuery();
          if(rs2.next()){
            int bid = rs2.getInt("book_id");
            PreparedStatement up = con.prepareStatement("UPDATE books SET issued_copies = issued_copies - 1 WHERE id=?");
            up.setInt(1,bid); up.executeUpdate();
          }
          out.println("<div class='success'>Returned</div>");
        }catch(Exception e){ out.println("<div class='error'>"+e.getMessage()+"</div>"); }
      }
    %>
  </div>
</div>
</body></html>
