<%-- 
    Document   : viewallcomment
    Created on : 13-Feb-2024, 1:28:18 pm
    Author     : admin
--%>

<%@page import="entity.student"%>
<%@page import="entity.college"%>
<%@page import="dao.collegedao"%>
<%@page import="entity.visitor"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.comment"%>
<%@page import="dao.commentdao"%>


<%@page import="helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .comment{
                margin: 5px;
                border: 1px solid rgba(0,0,0,.125);
                box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                -webkit-box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                -moz-box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
            }
            .comment-contain
            {
                background-color: transparent;
                box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                margin-top: 1rem !important;
            }
            .comment-contain img{
                width: 2rem;
                height:2rem;
                border-right:50% !important;

            }
            .comment-header{
                display: flex;
                gap:0.5rem;
                align-items: center;
            }
            .comment-header p{
                position: relative;
                top: 0.3rem;
            }
            .reply-contain{
                display: flex;
                gap:0.5rem;
                display: flex;
                gap:0.5rem;
                align-items: center;
            }
            .comment-header p{
                position: relative;
                top: 0.3rem;
            }
            .reply-contain{
                display: flex;
                gap:0.5rem;
            }
            .like-dilike-icon-contain{
                background-color:transparent;

                padding: 0.3rem;
                border-radius:50%;
                color:black;
                /*                box-shadow: 0px 5px 10px -7px black;*/
            }


            .course-name{
                border-bottom:2px solid #8490ff;

            }
            /*main comment box contain all comment*/
            .our-comments{
                background-color:red !important;

                overflow:scroll;

                position:relative;

            }
            /*//send comment box */
            .comment-box{
                position:sticky;
                background-color:whitesmoke;
                z-index:99;
                color:whitesmoke;
                bottom:0rem;
                border-radius: 0.5rem;


                z-index:9999 !important;

            }
            .comment_contain_section{
                padding:2rem 0rem;
            }
        </style>
        <%@include file="./links.html"%>
    </head>
    <body>
        <%--<%@include file="./navbar.jsp"%>--%>
<!--        <div class="container comment_contain_section">
            <div class="row">-->
                <%
                    //visitor vs1 = (visitor) session.getAttribute("visitorlogin");
                    student st =(student)session.getAttribute("loginstudent");
                    int sid = st.getSid();
                    commentdao cd1 = new commentdao(ConnectionProvider.getConnection());
                    Vector<comment> vc = cd1.getstudentcomment(sid);
                    Iterator<comment> it = vc.iterator();
                    if(it.hasNext())
                    {
                    while (it.hasNext()) {

                        comment cm = it.next();
                %>
                <div class="col-11 col-md-4 comment-contain mb-2 ">
                    <div class="comment-header">
                        <img src="./userimg/<%=st.getSimg()%>" alt="" style="border-radius:50%;"/>
                        <p style="font-size: 0.8rem;opacity: 60%" ><%=st.getSname() %></p>

                    </div>
                    <div class="comment-text mt-1">
                        <p class="mb-1">
                            <%=cm.getComment()%>
                        </p>
                    </div>

                    <div class="reply-contain mb-0 p-0 m-0">
                        <p style="font-size:0.8rem" class="p-0 m-0">Likes  <%
                            commentdao cd2 = new commentdao(ConnectionProvider.getConnection());
                            out.println(cd2.countlike(cm.getCom_id()));
                            %></p>
                        <p style="font-size:0.8rem;margin-left:5px" class="p-0 m-0">DisLikes  <%
                            out.println(cd2.countdislike(cm.getCom_id()));
                            %></p>
                    </div>
                    <div class="d-flex" style="position: relative">
                        <p style="font-size:0.8rem;color:gray;" class="mt-1"><%
                            collegedao cd = new collegedao(ConnectionProvider.getConnection());
                            college col = cd.findcollege(cm.getCid());
                            out.println(col.getCname());
                            %></p>

                        <i class="bi bi-trash3-fill  text-danger delete-com" style="position: absolute;right:0px;"></i>
                        <input type="hidden" value="<%=cm.getCom_id()%>">
                    </div>

                </div>

                <%}} else{

   out.println("<h5 class='text-center' style='color:gray'>No any Feedback is found</h5>");
}%>

<!--            </div>
        </div>-->

        <%--<%@include  file="./footer.html" %>--%>

        <script src="./jquery/jquery.js"></script>
        <script>

            //comment delete by visitor
            $(".delete-com").on("click", function ()
            {
                let con = confirm("Are you sure to delete comment");
                if (con == true)
                {
                    let sib = $(this).siblings();
                    console.log(sib);
                    let com_id = $(sib[1]).attr("value");
                    console.log(com_id);

//                    let cid = $(sib[1]).attr("value");

                    $.ajax({
                        url: "deletecomment",
                        data: {"com_id": com_id},
                        success: function (data)
                        {

                            window.location.href = "./profile.jsp";
                        }
                    });
                }
            });
        </script>
    </body>

</html>

