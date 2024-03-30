      <%@page import="entity.student"%>
<%@page import="helper.RatingCount"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.teacher,java.sql.*"%>
<%@page import="dao.teacherdao"%>
<%@page import="helper.ConnectionProvider"%>
<%
                student stu = (student) session.getAttribute("loginstudent");
                          Connection con = ConnectionProvider.getConnection();
                           int cid = Integer.parseInt(request.getParameter("cid"));
                           String c_name = request.getParameter("c_name");
                           c_name = c_name.trim();
                            teacherdao td = new teacherdao(ConnectionProvider.getConnection());
                            Vector<teacher> vc = td.getteachers(cid,c_name);
                            Iterator<teacher> it = vc.iterator();
                            if(it.hasNext())
                            {
                            while (it.hasNext()) {
                                teacher tech = it.next();

                        %>


                        <div class="col-sm-6 col-md-4">
                            <div class="card mb-3 card1">
                                <div class="row g-0 align-items-center justify-content-between">
                                    <div class="col-4 col-md-4">
                                        <img src="./userimg/<%= tech.getTimg()%>" class="img-fluid rounded-start teacher-img" alt="...">
                                    </div>
                                    <div class="col-8 col-md-8">
                                        <div class="card-body">
                                            <h5 class="card-title"><%= tech.getTname()%></h5>

                                            <div class="card-text mb-0 d-flex">
                                                <p class="card-text mb-0"><%= tech.getTsem()%>(<%= tech.getTsection()%>)</p>    <p class="card-text mb-0">  <%= tech.getTsubject()%></p>
                                            </div>
                                            <div>
                                                <p class="mb-0 ">
                                                    <span class="teacher-rv">
                                                        <%
                                                          String  qtr = "select sum(t_rval) from tech_rating where tid=" + tech.getTid();
                                                          Statement  st = con.createStatement();
                                                           ResultSet rs = st.executeQuery(qtr);
                                                           float star = 0;
                                                            if (rs.next()) {
                                                                star = rs.getFloat(1);

                                                            }

                                                          String  qtr1 = "select count(sid) from tech_rating where tid=?";
                                                          PreparedStatement  ps = con.prepareStatement(qtr1);

                                                            ps.setInt(1, tech.getTid());
                                                           ResultSet rs1 = ps.executeQuery();
                                                           int user = 0;
                                                            if (rs1.next()) {

                                                                user = rs1.getInt(1);

                                                            }
                                                            out.print(RatingCount.rcount(star, user));
                                                        %>
                                                    </span>
                                                    <span><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i></span> </p>
                                            </div>
                                            <i class="bi bi-person-fill-check"></i>
                                            <%
                                                out.println(user);

                                                if (stu != null) {
                                                    if (stu.getCid() ==cid) {
                                            %>
                                            <span class="bi bi-star rat-star1" data-bs-toggle="modal" data-bs-target="#exampleModaltech" value="<%=tech.getTid()%>"> Rate</span> 
                                            <%}
                                                }%>
                                            <div class="card-identy" style="display:none" value="teacher"></div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <% }}else
{
   out.println("<h5 class='text-center mt-2' style='color:gray'>No any teacher is found in this course</h5>");
}%>
<script src="./jquery/jquery.js"></script>
<script>
       val = $(".teacher-rv");
             c1, nextele, nextchild;
            for (c1 = 0; c1 < val.length; c1++)
            {
                let inn1 = parseInt(val[c1].innerText);
                nextele = $(val[c1]).next();
                nextchild = nextele.children();

                for (x = inn1; x < 5; x++)
                {


                    $(nextchild[x]).removeClass("star-bg");
                }

                if (inn1 < val[c1].innerText)
                {


                    $(nextchild[inn1]).removeClass("bi-star-fill");
                    $(nextchild[inn1]).addClass("bi-star-half");
                    $(nextchild[inn1]).addClass("star-bg");
                }
            }
                  //send rating to database
            tid;
            $(".rat-star1").on("click", function ()
            {
                tid = $(this).attr("value");
            });
            $(".teacher-post").on("click", function ()
            {
                //console.log("CLICK USERPOST2"); 
                let stat_fill = $(".counting-star1").text();

                let selected_card = "Teacher";
                let firstthis = this;
                let card_id = tid;
                $.ajax({
                    url: "addcollegerating",
                    data: {"star_fill": stat_fill, "select_card": selected_card, "cid": cid, "sid": sid, "id": card_id},
                    success: function (data)
                    {
                        let parent = $(firstthis).parent();
                        let sib = $(parent).siblings();
                        console.log(parent);
                        $(parent).html(" ");
                        $(sib[1]).html("<div class='alert alert-success mt-1' role='alert'>Your rating seccussfully added </div>");
                    }
                });
            });
</script>
