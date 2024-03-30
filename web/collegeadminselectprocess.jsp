<%@page import="entity.course"%>
<%@page import="helper.message"%>
<%@page import="helper.RatingCount"%>
<%@page import="entity.college"%>
<%@page import="dao.collegedao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.collegeadmindao"%>
<%@page import="entity.collegeadmin,java.sql.*"%>
<style>
.collegeadmin-college-img
{
    width:14rem !important;
    height:14rem !important;
}
@media (max-width:750px)
{
    .collegeadmin-img-contain{
        
        display: flex;
        justify-content: center;
    }
}

</style>
<div class="row">
    <div class="col-10">
               <% 
                            message mg = (message)session.getAttribute("updatecollege");
                            if(mg!=null)
                            {
                            
                         
                         %>
                     <div class="alert alert-danger" role="alert">
                  <%= mg.getMsg() %>
                     </div>
                  <% mg=null;session.setAttribute("updatecollege",mg);} %>
    </div>
</div>
<%
    collegeadmin cd = (collegeadmin) session.getAttribute("collegeadmin");
    collegedao clgdao = new collegedao(ConnectionProvider.getConnection());
    college col = clgdao.findcollege(cd.getCid());
    if (cd != null) {
%>
<div class="card border-0" style="box-shadow:none;background-color:transparent;color:rgb(50, 50, 50)!important;">
    <div class="row g-0">
        <div class="col-md-6 ps-5">
            <div class="card-body">
                <h5 class="card-title"><%= col.getCname()%></h5>
                <p class="card-text mb-1 popular-college-detail"> 

                    <%= col.getCdesc()%>
                </p>

                <p class=""><b>Course</b> :  <% 
                                        course cou = col.getCoure();
                                        String qtr2 = "select c_name from course where cid=?";
                                        Connection con1 = ConnectionProvider.getConnection();
                                        PreparedStatement ps1 = con1.prepareStatement(qtr2);
                                        ps1.setInt(1,col.getCid());
                                        ResultSet rs2 = ps1.executeQuery();
                                        while(rs2.next())
                                        {
                                          out.println(rs2.getString(1));
                                      }
                                      %>
                </p>
                <p class=""><b>Our Activity</b> : <%= col.getCactivity()%>
                </p>
                <div class="mb-0">
                    <span class="rat-value">
                        <%
                                      Connection con = ConnectionProvider.getConnection();
                                                            String qtr =  "select sum(c_rval) from coll_rating where cid="+cd.getCid();
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery(qtr);
                             float star=0;
                            if(rs.next())
                            {
                            star = rs.getFloat(1);
                                      }
                            qtr = "select count(sid) from coll_rating where cid="+cd.getCid();
                            st=con.createStatement();
                            rs = st.executeQuery(qtr);
                            float user=0;
                            if(rs.next())
                            {
                             user = rs.getFloat(1);
                                      }
                            out.print(RatingCount.rcount(star,user));
                               
%></span>
                        <span class="ms-2">
                            <i class="bi bi-star-fill star-bg"></i><i
                                class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i
                                class="bi bi-star-fill"></i></span>
                        &nbsp;&nbsp;<button type="button" class="btn btn-sm btn1 text-white edit"  data-bs-toggle="modal" data-bs-target="#exampleModal4">Edit</button>
                          <p class="popular-college-detail mb-0 fs-6"><i class="bi bi-person-fill-check"></i>
                            <%= user %>
                        </p>
                </div>

            </div>
        </div>
        <div class="col-md-4 collegeadmin-img-contain">
            <img src="./userimg/<%= col.getCimg()%>" class="img-fluid rounded-start collegeadmin-college-img img-fluid py-2 px-2" alt="...">
        </div>

    </div>
</div> 


<!--college edit--> 
<div class="modal fade" style="z-index:9999 !important;" id="exampleModal4" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">College Update</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <form action="editcollege" method="post" enctype="multipart/form-data">
                    <div class="mb-1">
                        <label for="sen_no" class="form-label">Name</label>
                        <input type="text" class="form-control" id="cname" name="cname" class="cname">
                    </div>


                    <div class="mb-1">
                        <label for="ssection" class="form-label">Description</label>
                        <textarea class="form-control" id="cdesc" name="cdesc" class="cdesc"></textarea>
                    </div>

                    <div class="mb-1">
                        <label for="ssection" class="form-label">Activity</label>
                        <input type="text" class="form-control" id="cactivity" class="cactivity" name="cactivity">
                    </div>

            

<!--                    <div class="mb-1">
                        <label for="ssection" class="form-label">Email</label>
                        <input type="text" class="form-control" id="cemail" name="cemail" class="cemail">
                    </div>-->
                        <div class="mb-1">
                        <label for="ssection" class="form-label">Address</label>
                        <textarea class="form-control" id="caddress" name="caddress" class="caddress"></textarea>
                    </div>
                    <div class="mb-1">
                        <label for="cimg" class="form-label">Image</label>
                        <input type="file" class="form-control" id="cimg" name="cimg">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update</button>
                    </div>


                    <input type="hidden" value=<%= cd.getCid() %> name="cid" class="cid"/>
                </form>
            </div>

        </div>
    </div>


</div>

<% } else {
        response.sendRedirect("./collegeadminlogin.jsp");
    }
%>
<script src="./jquery/jquery.js"></script>

<script>

    
   cid = $(".cid").attr("value");

//set star based on database
     rat = $(".rat-value").text();
     nexele = $($(".rat-value").next()).children();
     rat=rat.trim();
     fill = parseInt(rat);

   
    for (x = fill; x < 5; x++)
    {
  
        $(nexele[x]).removeClass("star-bg");
    }
  
    if ( fill < rat)
    {
  
        $(nexele[fill]).removeClass("bi-star-fill");
        $(nexele[fill]).addClass("bi-star-half");
        $(nexele[fill]).addClass("star-bg");
       
    }
    
    
  //edit btn click
   $(".edit").on("click",function()
   {
       $.ajax({
          url:"editcollegeinfo",
          data:{"cid":<%= cd.getCid() %>},
          success:function(data)
          {
             let arr = data.split("^");
          console.log(arr);
            $("#cname").attr("value",arr[0]);
            
             $("#cdesc").text(arr[1]);
             $("#cactivity").attr("value",arr[2]);
             
             //$("#ccourse").attr("value",arr[3]);
//             $("#cemail").attr("value",arr[3]);
             $("#caddress").text(arr[4]);
          }
       });
       
   });
</script>

